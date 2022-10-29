import 'dart:async';

import 'package:sqflite_common/sqlite_api.dart';

Future<Database> openDatabase({
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) {
  throw UnsupportedError('Cannot open database on this platform');
}
