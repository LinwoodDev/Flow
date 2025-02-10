import 'dart:async';

import 'package:collection/collection.dart';
import 'dart:typed_data';
import 'package:flow_api/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class ResourceDatabaseService extends ResourceService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS resources (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        address TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) async {
    if (version < 5) {
      await db.execute("ALTER TABLE places RENAME TO resources");
    }
  }

  @override
  Future<Resource?> createResource(Resource resource) async {
    final id = resource.id ?? createUniqueUint8List();
    resource = resource.copyWith(id: id);
    final row = await db?.insert('resources', resource.toDatabase());
    if (row == null) return null;
    return resource;
  }

  @override
  Future<bool> deleteResource(Uint8List id) async {
    return await db?.delete(
          'resources',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<Resource>> getResources(
      {int offset = 0, int limit = 50, String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
    final result = await db?.query(
      'resources',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map(Resource.fromDatabase).toList();
  }

  @override
  FutureOr<Resource?> getResource(Uint8List id) async {
    final result = await db?.query(
      'resources',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Resource.fromDatabase).firstOrNull;
  }

  @override
  Future<bool> updateResource(Resource resource) async {
    return await db?.update(
          'resources',
          resource.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [resource.id],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('resources');
  }
}
