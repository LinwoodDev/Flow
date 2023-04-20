import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<DatabaseService>? _service;

Handler middleware(Handler handler) {
  return handler.use(
    provider<Future<DatabaseService>>(
      (context) => _service ?? _openService(),
    ),
  );
}

Future<Database> _openDatabase({
  String name = 'flow',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) async {
  sqfliteFfiInit();
  final factory = databaseFactoryFfi;
  final db = await factory.openDatabase(
    '$name.db',
    options: OpenDatabaseOptions(
      version: version,
      onUpgrade: onUpgrade,
      onCreate: onCreate,
    ),
  );
  return db;
}

Future<DatabaseService> _openService() async {
  final service = DatabaseService(_openDatabase);
  await service.setup('flow');
  return service;
}
