import 'dart:async';

import 'package:collection/collection.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class GroupDatabaseService extends GroupService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS groups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        parentId INTEGER
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<Group?> createGroup(Group group) async {
    final id = await db?.insert('groups', group.toDatabase()..remove('id'));
    if (id == null) return null;
    return group.copyWith(id: id.toString());
  }

  @override
  Future<bool> deleteGroup(String id) async {
    return await db?.delete(
          'groups',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<Group>> getGroups(
      {int offset = 0, int limit = 50, String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
    final result = await db?.query(
      'groups',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map(Group.fromDatabase).toList();
  }

  @override
  Future<Group?> getGroup(String id) async {
    final result = await db?.query(
      'groups',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Group.fromDatabase).firstOrNull;
  }

  @override
  Future<bool> updateGroup(Group group) async {
    return await db?.update(
          'groups',
          group.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [group.id],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('groups');
  }
}
