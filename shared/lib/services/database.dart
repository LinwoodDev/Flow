import 'dart:async';

import 'package:shared/models/event/database.dart';
import 'package:shared/models/user/database.dart';
import 'package:shared/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DatabaseService extends SourceService {
  final Database db;
  @override
  late final EventDatabaseService event;
  @override
  late final EventGroupDatabaseService eventGroup;

  @override
  late final UserDatabaseService user;
  @override
  late final UserGroupDatabaseService userGroup;

  DatabaseService(this.db) {
    setup();
  }

  void setup() {
    db.execute("PRAGMA foreign_keys = ON");

    event = EventDatabaseService(db);
    eventGroup = EventGroupDatabaseService(db);

    user = UserDatabaseService(db);
    userGroup = UserGroupDatabaseService(db);
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
