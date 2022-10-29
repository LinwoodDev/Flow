import 'dart:async';

import 'package:shared/models/event/database.dart';
import 'package:shared/models/user/database.dart';
import 'package:shared/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

typedef DatabaseFactory = Database Function(
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
);

const databaseVersion = 1;

class DatabaseService extends SourceService {
  late final Database db;
  @override
  late final EventDatabaseService event;
  @override
  late final EventGroupDatabaseService eventGroup;

  @override
  late final UserDatabaseService user;
  @override
  late final UserGroupDatabaseService userGroup;

  DatabaseService(DatabaseFactory databaseFactory) {
    _setup(databaseFactory);
  }

  void _setup(DatabaseFactory databaseFactory) {
    db = databaseFactory(databaseVersion, _onUpgrade, _onCreate);
    db.execute("PRAGMA foreign_keys = ON");

    event = EventDatabaseService(db);
    eventGroup = EventGroupDatabaseService(db);

    user = UserDatabaseService(db);
    userGroup = UserGroupDatabaseService(db);
  }

  List<TableService> get tables => models.cast<TableService>();

  FutureOr<void> _onCreate(Database db, int version) async {
    for (var table in tables) {
      await table.create();
    }
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var table in tables) {
      await table.migrate(newVersion);
    }
  }

  Future<int> getVersion() {
    return db.getVersion();
  }

  Future<int> getSqliteVersion() async {
    return (await db.rawQuery('SELECT sqlite_version()')).first.values.first
        as int;
  }
}

mixin TableService {
  Database get db;

  FutureOr<void> create();
  FutureOr<void> migrate(int version);
}
