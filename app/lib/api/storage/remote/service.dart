import 'package:flow/api/storage/remote/caldav.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/remote/sia.dart';
import 'package:flow/models/request.dart';
import 'package:http/http.dart';
import 'package:flow_api/models/cached.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/database.dart';
import 'package:flow_api/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart' show Database;

import 'ical.dart';

final class RemoteSyncException implements Exception {
  final int failedRequests;

  const RemoteSyncException(this.failedRequests);

  @override
  String toString() =>
      '$failedRequests offline change${failedRequests == 1 ? '' : 's'} '
      'could not be uploaded. Check the connection and account credentials, '
      'then try again.';
}

class RequestDatabaseService extends ModelService with TableService {
  @override
  Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS request (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        created INTEGER NOT NULL,
        data TEXT NOT NULL
      )
    ''');
  }

  Future<int?> createRequest(APIRequest request) async {
    return db?.insert('request', {
      'created': DateTime.now().millisecondsSinceEpoch,
      'data': request.toJson(),
    });
  }

  Future<List<ConnectedModel<int, APIRequest>>> getRequests({
    int offset = 0,
    int limit = 50,
  }) async {
    final result = await db?.query(
      'request',
      limit: limit,
      offset: offset,
      orderBy: 'created ASC',
    );
    if (result == null) return [];
    return result
        .map(
          (e) => ConnectedModel(
            e['id'] as int,
            APIRequestMapper.fromJson(e['data'] as String),
          ),
        )
        .toList();
  }

  Future<bool> deleteRequest(int id) async {
    return await db?.delete('request', where: 'id = ?', whereArgs: [id]) == 1;
  }
}

class RemoteDatabaseService extends DatabaseService {
  late final RequestDatabaseService request;

  @override
  List<ModelService> get models => [...super.models, request];

  RemoteDatabaseService(super.databaseFactory);

  @override
  Future<void> setup(String name) {
    request = RequestDatabaseService();
    return super.setup(name);
  }
}

abstract class RemoteService<T extends RemoteStorage> extends SourceService {
  final RemoteDatabaseService local;
  final T remoteStorage;
  final String? password;
  bool _enableRequests = true;

  RemoteService(this.remoteStorage, this.local, this.password);

  factory RemoteService.fromStorage(
    RemoteDatabaseService local,
    T storage,
    String? password,
  ) {
    return switch (storage) {
      CalDavStorage() =>
        CalDavRemoteService(storage, local, password) as RemoteService<T>,
      ICalStorage() =>
        IcalRemoteService(storage, local, password) as RemoteService<T>,
      WebDavStorage() => throw UnimplementedError(),
      SiaStorage() =>
        SiaRemoteService(storage, local, password) as RemoteService<T>,
    };
  }

  Future<void> synchronize() async {
    final requests = await local.request.getRequests();
    var failedRequests = 0;
    for (final request in requests) {
      try {
        final response = await request.model.send();
        if (response.statusCode >= 200 && response.statusCode < 300) {
          await local.request.deleteRequest(request.source);
        } else {
          failedRequests++;
        }
      } catch (_) {
        failedRequests++;
      }
    }
    if (failedRequests > 0) {
      throw RemoteSyncException(failedRequests);
    }
  }

  Future<Response?> addRequest(APIRequest apiRequest) async {
    if (!_enableRequests) return null;
    try {
      final response = await apiRequest.send();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        await local.request.createRequest(apiRequest);
      }
      return response;
    } catch (_) {
      await local.request.createRequest(apiRequest);
    }
    return null;
  }

  @override
  Future<void> import(CachedData data, [bool clear = true]) async {
    _enableRequests = false;
    await super.import(data, clear);
    _enableRequests = true;
  }
}
