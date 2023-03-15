import 'dart:async';

import 'package:shared/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../models/event/database.dart';
import '../models/place/database.dart';
import '../models/user/database.dart';
import '../models/group/database.dart';
import '../models/todo/database.dart';

typedef DatabaseFactory = Future<Database> Function({
  String name,
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
  late final TodoDatabaseService todo;
  @override
  late final GroupDatabaseService group;

  @override
  late final UserDatabaseService user;
  @override
  late final PlaceDatabaseService place;

  final DatabaseFactory databaseFactory;

  DatabaseService(this.databaseFactory);

  Future<void> setup(String name) async {
    event = EventDatabaseService();
    todo = TodoDatabaseService();
    place = PlaceDatabaseService();
    group = GroupDatabaseService();

    user = UserDatabaseService();

    db = await databaseFactory(
        name: name,
        version: databaseVersion,
        onUpgrade: _onUpgrade,
        onCreate: _onCreate);
    db.execute("PRAGMA foreign_keys = ON");
    for (final table in tables) {
      table.opened(db);
    }
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
