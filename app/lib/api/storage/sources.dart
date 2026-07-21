import 'dart:async';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flow/api/storage/db/database.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/remote/service.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flow_api/services/database.dart';
import 'package:flow_api/services/source.dart';

final class SyncFailure {
  final String source;
  final String message;

  const SyncFailure({required this.source, required this.message});
}

final class SyncState {
  final SyncStatus status;
  final List<SyncFailure> failures;
  final DateTime? lastSuccessfulSync;

  const SyncState({
    this.status = SyncStatus.synced,
    this.failures = const [],
    this.lastSuccessfulSync,
  });
}

class SourcesService {
  final SettingsCubit settingsCubit;
  late final DatabaseService local;
  final List<RemoteService> remotes = [];
  final BehaviorSubject<SyncState> syncState = BehaviorSubject.seeded(
    const SyncState(),
  );
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );
  Future<SyncState>? _activeSync;

  SourcesService(this.settingsCubit);

  Future<bool> shouldSync() async {
    final mode = settingsCubit.state.syncMode;
    if (mode == SyncMode.manual) {
      return false;
    }
    if (mode == SyncMode.always) {
      return true;
    }
    return !(await Connectivity().checkConnectivity()).contains(
      ConnectivityResult.mobile,
    );
  }

  Future<void> setup() async {
    local = DatabaseService(openDatabase);
    await local.setup('local');
    remotes.clear();
    for (var storage in settingsCubit.state.remotes) {
      await _connectRemote(
        storage,
        await secureStorage.read(key: 'remote ${storage.toFilename()}'),
      );
    }
    unawaited(synchronize());
  }

  Future<SyncState> synchronize([bool force = false]) {
    final activeSync = _activeSync;
    if (activeSync != null) return activeSync;

    final operation = _runSynchronization(force);
    _activeSync = operation;
    return operation.whenComplete(() {
      if (identical(_activeSync, operation)) {
        _activeSync = null;
      }
    });
  }

  Future<SyncState> _runSynchronization(bool force) async {
    try {
      return await _synchronize(force);
    } catch (error, stackTrace) {
      final failure = SyncFailure(
        source: 'Synchronization',
        message: error.toString(),
      );
      final state = SyncState(
        status: SyncStatus.error,
        failures: [failure],
        lastSuccessfulSync: syncState.value.lastSuccessfulSync,
      );
      syncState.add(state);
      debugPrint('Synchronization failed before a source completed');
      debugPrintStack(stackTrace: stackTrace);
      return state;
    }
  }

  Future<SyncState> _synchronize(bool force) async {
    if (!force && !(await shouldSync())) {
      return syncState.value;
    }
    final previous = syncState.value;
    syncState.add(
      SyncState(
        status: SyncStatus.syncing,
        lastSuccessfulSync: previous.lastSuccessfulSync,
      ),
    );
    final failures = <SyncFailure>[];
    for (final remote in remotes) {
      try {
        await remote.synchronize();
      } catch (error, stackTrace) {
        failures.add(
          SyncFailure(
            source: remote.remoteStorage.displayName,
            message: error.toString(),
          ),
        );
        debugPrint('Failed to synchronize ${remote.remoteStorage.displayName}');
        debugPrintStack(stackTrace: stackTrace);
      }
    }
    final state = SyncState(
      status: failures.isEmpty ? SyncStatus.synced : SyncStatus.error,
      failures: List.unmodifiable(failures),
      lastSuccessfulSync: failures.isEmpty
          ? DateTime.now()
          : previous.lastSuccessfulSync,
    );
    syncState.add(state);
    return state;
  }

  Future<void> _connectRemote(RemoteStorage storage, String? password) async {
    final db = RemoteDatabaseService(openDatabase);
    await db.setup(storage.toFilename());

    remotes.add(RemoteService.fromStorage(db, storage, password));
  }

  Future<void> addRemote(RemoteStorage remoteStorage, String password) async {
    if (settingsCubit.state.remotes.any(
      (element) => element.identifier == remoteStorage.identifier,
    )) {
      return;
    }
    final key = 'remote ${remoteStorage.toFilename()}';
    try {
      if (password.isNotEmpty) {
        await secureStorage.write(key: key, value: password);
      }
      await settingsCubit.addStorage(remoteStorage);
      await _connectRemote(remoteStorage, password);
      await synchronize();
    } catch (error, stackTrace) {
      try {
        remotes.removeWhere(
          (remote) =>
              remote.remoteStorage.identifier == remoteStorage.identifier,
        );
        await settingsCubit.removeStorage(remoteStorage.toFilename());
        await secureStorage.delete(key: key);
      } catch (_) {}
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> removeRemote(String name) async {
    await settingsCubit.removeStorage(name);
    try {
      await secureStorage.delete(key: 'remote $name');
    } catch (_) {}
    remotes.removeWhere(
      (element) => element.remoteStorage.toFilename() == name,
    );
    await synchronize();
  }

  List<RemoteStorage> getRemotes() => settingsCubit.state.remotes;

  SourceService getSource(String source) {
    if (source.isEmpty) return local;
    return remotes.firstWhereOrNull(
          (element) => element.remoteStorage.identifier == source,
        ) ??
        local;
  }

  Future<void> clearRemotes() async {
    for (final remote in List.of(remotes)) {
      await removeRemote(remote.remoteStorage.toFilename());
    }
  }

  RemoteStorage? getRemote(String key) => settingsCubit.getStorage(key);
}
