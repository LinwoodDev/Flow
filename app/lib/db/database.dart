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
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
}) {
  if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    return desktop.openDatabase(onUpgrade: onUpgrade, version: version);
  } else {
    return mobile.openDatabase(onUpgrade: onUpgrade, version: version);
  }
}
