import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'database_stub.dart'
    if (dart.library.html) 'database_html.dart'
    if (dart.library.io) 'database_desktop.dart' as desktop;
import 'database_stub.dart' if (dart.library.io) 'database_mobile.dart'
    as mobile;

Future<Database> openDatabase({
  String name = 'flow',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) {
  if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return desktop.openDatabase(
        onUpgrade: onUpgrade, onCreate: onCreate, version: version);
  } else {
    return mobile.openDatabase(
        onUpgrade: onUpgrade, onCreate: onCreate, version: version);
  }
}

Future<Uint8List> exportDatabase(Database database) {
  if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return desktop.exportDatabase(database);
  } else {
    return mobile.exportDatabase(database);
  }
}
