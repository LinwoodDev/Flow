import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/models/user/service.dart';
import 'package:flow_api/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserDatabaseService extends UserService with TableService {
  UserDatabaseService();

  @override
  Future<void> create(DatabaseExecutor db, [String name = 'users']) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS $name (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        email VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        phone VARCHAR(100) NOT NULL DEFAULT '',
        image BLOB
      )
    """);
  }

  @override
  Future<User?> createUser(User user) async {
    final id = user.id ?? createUniqueUint8List();
    user = user.copyWith(id: id);
    final row = await db?.insert('users', user.toDatabase());
    if (row == null) return null;
    return user;
  }

  @override
  Future<bool> deleteUser(Uint8List id) async {
    return await db?.delete(
          'users',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<User>> getUsers({
    int offset = 0,
    int limit = 50,
    String search = '',
    Uint8List? groupId,
  }) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$search%'];
    }
    if (groupId != null) {
      where = where == null ? 'groupId = ?' : '$where AND groupId = ?';
      whereArgs = whereArgs == null ? [groupId] : [...whereArgs, groupId];
    }
    final result = await db?.query(
      'users',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
    );
    if (result == null) return [];
    return result.map(User.fromDatabase).toList();
  }

  @override
  Future<bool> updateUser(User user) async {
    return await db?.update(
          'users',
          user.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [user.id],
        ) ==
        1;
  }

  @override
  Future<User?> getUser(Uint8List id) async {
    return await db?.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    ).then((value) {
      if (value.isEmpty) return null;
      return User.fromDatabase(value.first);
    });
  }

  @override
  Future<void> clear() async {
    await db?.delete('users');
  }
}
