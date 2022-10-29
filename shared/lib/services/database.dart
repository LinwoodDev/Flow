import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';

class DatabaseManager {
  final Database db;

  DatabaseManager(this.db);

  void setup() {
    db.execute("PRAGMA foreign_keys = ON");
  }
}

mixin DatabaseService {
  Database get db;

  FutureOr<void> create();
  FutureOr<void> migrate(int version);
}
