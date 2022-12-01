import 'dart:async';

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
        id INTEGER PRIMARY KEY,
        teamId INTEGER,
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
    final id = await db?.insert('users', user.toJson()..remove('id'));
    if (id == null) return null;
    return user.copyWith(id: id);
  }

  @override
  Future<bool> deleteUser(int id) async {
    return await db?.delete(
          'users',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<User>> getUsers(
      {int offset = 0, int limit = 50, String search = ''}) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$search%'];
    }
    final result = await db?.query(
      'users',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
    );
    if (result == null) return [];
    return result.map((e) => User.fromJson(e)).toList();
  }

  @override
  Future<bool> updateUser(User user) async {
    return await db?.update(
          'users',
          user.toJson()..remove('id'),
          where: 'id = ?',
          whereArgs: [user.id],
        ) ==
        1;
  }
}
