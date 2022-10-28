import 'dart:ffi';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/open.dart';

import '../server.dart';

const _databaseVersion = 0;

class DatabaseModule extends Module {
  CommonDatabase? _db;

  DatabaseModule(super.server);

  @override
  Future<void> start() async {
    open.overrideFor(OperatingSystem.linux, _openOnLinux);
    open.overrideFor(OperatingSystem.macOS, _openOnMacOS);
    open.overrideFor(OperatingSystem.windows, _openOnWindows);
    for (final module in server.modules) {
      await module.migrate(_databaseVersion);
    }
    printInfo(getDatabaseVersion().toString());
    _setDatabaseVersion();
  }

  void _setDatabaseVersion() {
    _db?.execute("PRAGMA user_version = $_databaseVersion");
  }

  int getDatabaseVersion() {
    return _db
            ?.select("PRAGMA user_version")
            .map((row) => row[0])
            .firstOrNull ??
        _databaseVersion;
  }

  @override
  void stop() {
    _db?.dispose();
  }

  Directory _getScriptPath() {
    return Directory(Platform.script.toFilePath()).parent;
  }

  DynamicLibrary _openOnLinux() {
    final libraryNextToScript = File('${_getScriptPath().path}/sqlite3.so');
    return DynamicLibrary.open(libraryNextToScript.path);
  }

  DynamicLibrary _openOnMacOS() {
    final libraryNextToScript = File('${_getScriptPath().path}/sqlite3.dylib');
    return DynamicLibrary.open(libraryNextToScript.path);
  }

  DynamicLibrary _openOnWindows() {
    final libraryNextToScript = File('${_getScriptPath().path}/sqlite3.dll');
    return DynamicLibrary.open(libraryNextToScript.path);
  }
}
