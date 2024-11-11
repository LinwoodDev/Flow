import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flow_api/models/event/item/database.dart';
import 'package:flow_api/models/label/database.dart';
import 'package:flow_api/models/note/event.dart';
import 'package:flow_api/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../models/event/database.dart';
import '../models/note/item.dart';
import '../models/note/label.dart';
import '../models/place/database.dart';
import '../models/user/database.dart';
import '../models/group/database.dart';
import '../models/note/database.dart';

typedef DatabaseFactory = Future<Database> Function({
  String name,
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
});

const databaseVersion = 3;

class DatabaseService extends SourceService {
  late final Database db;
  @override
  final EventDatabaseService event = EventDatabaseService();
  @override
  final CalendarItemDatabaseService calendarItem =
      CalendarItemDatabaseService();
  @override
  final NoteDatabaseService note = NoteDatabaseService();
  @override
  final LabelNoteDatabaseConnector labelNote = LabelNoteDatabaseConnector();
  @override
  final EventNoteDatabaseConnector eventNote = EventNoteDatabaseConnector();
  @override
  final CalendarItemNoteDatabaseConnector calendarItemNote =
      CalendarItemNoteDatabaseConnector();
  @override
  final GroupDatabaseService group = GroupDatabaseService();
  @override
  final UserDatabaseService user = UserDatabaseService();
  @override
  final PlaceDatabaseService place = PlaceDatabaseService();
  @override
  final LabelDatabaseService label = LabelDatabaseService();

  final DatabaseFactory databaseFactory;

  DatabaseService(this.databaseFactory);

  Future<void> setup(String name) async {
    db = await databaseFactory(
        name: name,
        version: databaseVersion,
        onUpgrade: _onUpgrade,
        onCreate: _onCreate);
    db.execute("PRAGMA foreign_keys = ON");
    for (final table in tables) {
      table.opened(db);
    }
  }

  List<TableService> get tables => [...models.cast<TableService>()];

  FutureOr<void> _onCreate(Database db, int version) async {
    for (var table in tables) {
      await table.create(db);
    }
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var table in tables) {
      await table.migrate(db, oldVersion);
    }
  }

  Future<int> getVersion() {
    return db.getVersion();
  }

  Future<String> getSqliteVersion() async {
    return (await db.rawQuery('SELECT sqlite_version()'))
        .first
        .values
        .first
        .toString();
  }
}

mixin TableService {
  Database? db;

  FutureOr<void> create(Database db) {}
  FutureOr<void> migrate(Database db, int version) {}
  FutureOr<void> opened(Database db) {
    this.db = db;
  }

  FutureOr<void> clear() {}
}
Uint8List encodeEndian(int value, int length) {
  final res = Uint8List(length);

  for (int i = 0; i < length; i++) {
    res[i] = value & 0xff;
    value = value >> 8;
  }
  return res;
}

Uint8List createUniqueUint8List() {
  final random = Random.secure();
  final uuid = Uint8List.fromList(
      encodeEndian(DateTime.now().millisecondsSinceEpoch, 8) +
          List.generate(8, (i) => random.nextInt(255)));
  return uuid;
}

Uint8List createEmptyUint8List() {
  return Uint8List(0);
}
