import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'
    show databaseFactoryFfiWeb;

Future<Database> openDatabase({
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) async {
  var factory = databaseFactoryFfiWeb;
  var db = await factory.openDatabase(
    'flow.db',
    options: OpenDatabaseOptions(
      version: version,
      onUpgrade: onUpgrade,
      onCreate: onCreate,
    ),
  );
  return db;
}
