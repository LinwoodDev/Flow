import 'dart:convert';

import 'package:flow/api/storage/remote/caldav.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/remote/sia.dart';
import 'package:flow/models/request.dart';
import 'package:shared/models/model.dart';
import 'package:shared/services/database.dart';
import 'package:shared/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart' show Database;

class RequestDatabaseService extends ModelService with TableService {
  @override
  Future<void> create(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS request (
        id INTEGER PRIMARY KEY,
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

  Future<List<ConnectedModel<DateTime, APIRequest>>> getRequests(
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      'request',
      limit: limit,
      offset: offset,
      orderBy: 'created DESC',
    );
    if (result == null) return [];
    return result
        .map((e) => ConnectedModel(
              DateTime.fromMillisecondsSinceEpoch(e['created'] as int),
              APIRequest.fromJson(json.decode(e['data'] as String)),
            ))
        .toList();
  }

  Future<bool> deleteRequest(int id) async {
    return await db?.delete(
          'request',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }
}

class RemoteDatabaseService extends DatabaseService {
  late final RequestDatabaseService request;

  @override
  List<ModelService> get models => [
        ...super.models,
        request,
      ];

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

  RemoteService(this.remoteStorage, this.local, this.password);

  factory RemoteService.fromStorage(
      RemoteDatabaseService local, T storage, String? password) {
    return storage.map(
      calDav: (value) =>
          CalDavRemoteService(value, local, password) as RemoteService<T>,
      webDav: (value) => throw UnimplementedError(),
      sia: (value) =>
          SiaRemoteService(value, local, password) as RemoteService<T>,
    );
  }

  Future<void> sync();
}
