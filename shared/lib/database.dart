import 'dart:async';

import 'package:sqlite3/common.dart';

class DatabaseManager {
  final CommonDatabase db;

  DatabaseManager(this.db);

  void setup() {
    db.execute("PRAGMA foreign_keys = ON");
  }
}

mixin DatabaseService {
  CommonDatabase get db;

  FutureOr<void> create();
  FutureOr<void> migrate(int version);
}
