import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/models/user/model.dart';
import 'package:shared/models/user/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserDatabaseService extends UserService with TableService {
  UserDatabaseService();

  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS users (
        id BLOB(16) PRIMARY KEY,
        groupId BLOB(16),
        name VARCHAR(100) NOT NULL DEFAULT '',
        email VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        phone VARCHAR(100) NOT NULL DEFAULT '',
        image BLOB
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<User?> createUser(User user) async {
    final id = user.id ?? createUniqueMultihash();
    user = user.copyWith(id: id);
    final row = await db?.insert('users', user.toDatabase());
    if (row == null) return null;
    return user;
  }

  @override
  Future<bool> deleteUser(Multihash id) async {
    return await db?.delete(
          'users',
          where: 'id = ?',
          whereArgs: [id.fullBytes],
        ) ==
        1;
  }

  @override
  Future<List<User>> getUsers({
    int offset = 0,
    int limit = 50,
    String search = '',
    Multihash? groupId,
  }) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$search%'];
    }
    if (groupId != null) {
      where = where == null ? 'groupId = ?' : '$where AND groupId = ?';
      whereArgs = whereArgs == null
          ? [groupId.fullBytes]
          : [...whereArgs, groupId.fullBytes];
    }
    final result = await db?.query(
      'users',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
    );
    if (result == null) return [];
    return result.map((e) => User.fromDatabase(e)).toList();
  }

  @override
  Future<bool> updateUser(User user) async {
    return await db?.update(
          'users',
          user.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [user.id?.fullBytes],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('users');
  }
}
