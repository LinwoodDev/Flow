import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/database.dart';
import 'package:sqlite3/common.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String description,
    @Default('') String phone,
    @Default([]) List<int> image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

class UserManager with DatabaseService {
  @override
  final CommonDatabase db;

  UserManager(this.db);

  @override
  void create() {
    db.execute("""
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
  FutureOr<void> migrate(int version) {}
}

@freezed
class UserGroup with _$UserGroup {
  const factory UserGroup({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
  }) = _UserGroup;

  factory UserGroup.fromJson(Map<String, dynamic> json) =>
      _$UserGroupFromJson(json);
}

class UserGroupManager with DatabaseService {
  @override
  final CommonDatabase db;

  UserGroupManager(this.db);

  @override
  void create() {
    db.execute("""
      CREATE TABLE IF NOT EXISTS userGroups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT
      )
    """);
    db.execute("""
      CREATE TABLE IF NOT EXISTS userGroupMembers (
        id INTEGER PRIMARY KEY,
        groupId INTEGER,
        userId INTEGER
      )
    """);
  }

  @override
  FutureOr<void> migrate(int version) {}
}
