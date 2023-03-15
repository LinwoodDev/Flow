import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sqflite show openDatabase;

Future<Database> openDatabase({
  String name = 'flow',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) async {
  var db = await sqflite.openDatabase(
    '$name.db',
    version: version,
    onUpgrade: onUpgrade,
    onCreate: onCreate,
  );
  return db;
}

Future<Uint8List> exportDatabase(Database database) {
  final path = database.path;
  final file = File(path);
  return file.readAsBytes();
}
