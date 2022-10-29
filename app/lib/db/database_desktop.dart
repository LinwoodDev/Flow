import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactoryFfi, sqfliteFfiInit;

Future<Database> openDatabase({
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
}) async {
  sqfliteFfiInit();
  var factory = databaseFactoryFfi;
  var db = await factory.openDatabase('flow.db');
  return db;
}
