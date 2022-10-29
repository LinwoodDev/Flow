import 'dart:async';

import 'package:shared/models/event/database.dart';
import 'package:shared/models/user/database.dart';
import 'package:shared/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

typedef DatabaseFactory = Future<Database> Function({
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
});

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

  final DatabaseFactory databaseFactory;

  DatabaseService(this.databaseFactory);

  Future<void> setup() async {
    event = EventDatabaseService();
    eventGroup = EventGroupDatabaseService();

    user = UserDatabaseService();
    userGroup = UserGroupDatabaseService();

    db = await databaseFactory(
        version: databaseVersion, onUpgrade: _onUpgrade, onCreate: _onCreate);
    db.execute("PRAGMA foreign_keys = ON");
  }

  List<TableService> get tables => models.cast<TableService>();

  FutureOr<void> _onCreate(Database db, int version) async {
    for (var table in tables) {
      await table.create(db);
    }
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var table in tables) {
      await table.migrate(db, oldVersion);
    }
  }

  Future<int> getVersion() {
    return db.getVersion();
  }

  Future<String> getSqliteVersion() async {
    return (await db.rawQuery('SELECT sqlite_version()'))
        .first
        .values
        .first
        .toString();
  }
}

mixin TableService {
  Database? db;

  FutureOr<void> create(Database db);
  FutureOr<void> migrate(Database db, int version);
  FutureOr<void> opened(Database db) {
    this.db = db;
  }
}
