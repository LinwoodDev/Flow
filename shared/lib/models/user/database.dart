import 'dart:async';

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
        name VARCHAR(100) NOT NULL DEFAULT '',
        email VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        phone VARCHAR(100) NOT NULL DEFAULT '',
        image TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}
}

class UserGroupDatabaseService extends UserGroupService with TableService {
  UserGroupDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS userGroups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE IF NOT EXISTS userGroupMembers (
        id INTEGER PRIMARY KEY,
        groupId INTEGER,
        userId INTEGER
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}
}
