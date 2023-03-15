import 'dart:async';
import 'dart:typed_data';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart'
    show SqfliteFfiWebOptions, createDatabaseFactoryFfiWeb;
import 'package:sqlite3/wasm.dart' show IndexedDbFileSystem;

const indexedDbName = 'sqflite_databases';

Future<Database> openDatabase({
  String name = 'flow',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) async {
  var factory = createDatabaseFactoryFfiWeb(
      options: SqfliteFfiWebOptions(
    indexedDbName: indexedDbName,
  ));
  var db = await factory.openDatabase(
    '$name.db',
    options: OpenDatabaseOptions(
      version: version,
      onUpgrade: onUpgrade,
      onCreate: onCreate,
    ),
  );
  return db;
}

Future<Uint8List> exportDatabase(Database database) async {
  final fs = await IndexedDbFileSystem.open(dbName: indexedDbName);
  final path = "/${database.path}";
  final size = fs.sizeOfFile(path);
  final target = Uint8List(size);
  fs.read(path, target, 0);
  return target;
}
