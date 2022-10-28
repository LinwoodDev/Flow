import 'dart:async';

import 'package:sqlite3/common.dart';

class DatabaseManager {
  final CommonDatabase db;

  DatabaseManager(this.db);

  void setup() {
    db.execute("PRAGMA foreign_keys = ON");
  }
}

abstract class TableManager {
  final CommonDatabase db;

  TableManager(this.db);

  FutureOr<void> create();
  FutureOr<void> migrate(int version);
}
