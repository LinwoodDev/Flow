import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flow/api/storage/db/database.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/remote/service.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flow_api/services/database.dart';
import 'package:flow_api/services/source.dart';

class SourcesService {
  final SettingsCubit settingsCubit;
  late final DatabaseService local;
  final List<RemoteService> remotes = [];
  final BehaviorSubject<SyncStatus> syncStatus =
      BehaviorSubject.seeded(SyncStatus.synced);
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  SourcesService(this.settingsCubit);

  Future<bool> shouldSync() async {
    final mode = settingsCubit.state.syncMode;
    if (mode == SyncMode.manual) {
      return false;
    }
    if (mode == SyncMode.always) {
      return true;
    }
    return await Connectivity().checkConnectivity() !=
        ConnectivityResult.mobile;
  }

  Future<void> setup() async {
    local = DatabaseService(openDatabase);
    await local.setup('local');
    remotes.clear();
    for (var storage in settingsCubit.state.remotes) {
      await _connectRemote(storage,
          await secureStorage.read(key: 'remote ${storage.toFilename()}'));
    }
    synchronize();
  }

  Future<void> synchronize([bool force = false]) async {
    if (!force && !(await shouldSync())) {
      return;
    }
    syncStatus.add(SyncStatus.syncing);
    for (final remote in remotes) {
      try {
        await remote.synchronize();
      } catch (e) {
        syncStatus.add(SyncStatus.error);
      }
    }
    if (syncStatus.value != SyncStatus.error) {
      syncStatus.add(SyncStatus.synced);
    }
  }

  Future<void> _connectRemote(RemoteStorage storage, String? password) async {
    final db = RemoteDatabaseService(openDatabase);
    await db.setup(storage.toFilename());

    remotes.add(RemoteService.fromStorage(db, storage, password));
  }

  Future<void> addRemote(RemoteStorage remoteStorage, String password) async {
    if (settingsCubit.state.remotes
        .any((element) => element.identifier == remoteStorage.identifier)) {
      return;
    }
    final key = 'remote ${remoteStorage.toFilename()}';
    if (password.isNotEmpty) {
      await secureStorage.write(key: key, value: password);
    }
    await settingsCubit.addStorage(remoteStorage);
    await _connectRemote(remoteStorage, password);
    await synchronize();
  }

  Future<void> removeRemote(String name) async {
    await settingsCubit.removeStorage(name);
    try {
      await secureStorage.delete(key: 'remote $name');
    } catch (_) {}
    remotes
        .removeWhere((element) => element.remoteStorage.toFilename() == name);
    await synchronize();
  }

  List<RemoteStorage> getRemotes() => settingsCubit.state.remotes;

  SourceService getSource(String source) {
    if (source.isEmpty) return local;
    return remotes.firstWhereOrNull(
            (element) => element.remoteStorage.identifier == source) ??
        local;
  }

  Future<void> clearRemotes() async {
    for (final remote in remotes) {
      await removeRemote(remote.remoteStorage.identifier);
    }
  }

  RemoteStorage? getRemote(String key) => settingsCubit.getStorage(key);
}
