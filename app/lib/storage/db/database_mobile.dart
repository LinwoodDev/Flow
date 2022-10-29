import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sqflite show openDatabase;

Future<Database> openDatabase({
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) async {
  var db = await sqflite.openDatabase(
    'flow.db',
    version: version,
    onUpgrade: onUpgrade,
    onCreate: onCreate,
  );
  return db;
}
