import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flow_api/models/event/group.dart';
import 'package:flow_api/models/event/item/database.dart';
import 'package:flow_api/models/event/item/group.dart';
import 'package:flow_api/models/event/item/user.dart';
import 'package:flow_api/models/event/user.dart';
import 'package:flow_api/models/label/database.dart';
import 'package:flow_api/models/label/group.dart';
import 'package:flow_api/models/label/user.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/note/event.dart';
import 'package:flow_api/models/note/group.dart';
import 'package:flow_api/models/note/user.dart';
import 'package:flow_api/models/resource/event.dart';
import 'package:flow_api/models/resource/group.dart';
import 'package:flow_api/models/resource/item.dart';
import 'package:flow_api/models/resource/user.dart';
import 'package:flow_api/models/user/group.dart';
import 'package:flow_api/services/migration.dart';
import 'package:flow_api/services/source.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../models/event/database.dart';
import '../models/note/item.dart';
import '../models/resource/database.dart';
import '../models/user/database.dart';
import '../models/group/database.dart';
import '../models/note/database.dart';

typedef DatabaseFactory = Future<Database> Function({
  String name,
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
});

const databaseVersion = 4;

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
  final UserNoteDatabaseConnector userNote = UserNoteDatabaseConnector();
  @override
  final GroupNoteDatabaseConnector groupNote = GroupNoteDatabaseConnector();
  @override
  final GroupDatabaseService group = GroupDatabaseService();
  @override
  final UserDatabaseService user = UserDatabaseService();
  @override
  final UserGroupDatabaseConnector userGroup = UserGroupDatabaseConnector();
  @override
  final ResourceDatabaseService resource = ResourceDatabaseService();
  @override
  late final EventResourceDatabaseConnector eventResource =
      EventResourceDatabaseConnector();
  @override
  final CalendarItemResourceDatabaseConnector calendarItemResource =
      CalendarItemResourceDatabaseConnector();
  @override
  final UserResourceDatabaseConnector userResource =
      UserResourceDatabaseConnector();
  @override
  final GroupResourceDatabaseConnector groupResource =
      GroupResourceDatabaseConnector();
  @override
  final LabelDatabaseService label = LabelDatabaseService();
  @override
  final EventUserDatabaseConnector eventUser = EventUserDatabaseConnector();
  @override
  final EventGroupDatabaseConnector eventGroup = EventGroupDatabaseConnector();
  @override
  final CalendarItemUserDatabaseConnector calendarItemUser =
      CalendarItemUserDatabaseConnector();
  @override
  final CalendarItemGroupDatabaseConnector calendarItemGroup =
      CalendarItemGroupDatabaseConnector();
  @override
  final UserNotebookDatabaseConnector userNotebook =
      UserNotebookDatabaseConnector();
  @override
  final GroupNotebookDatabaseConnector groupNotebook =
      GroupNotebookDatabaseConnector();
  @override
  final UserLabelDatabaseConnector userLabel = UserLabelDatabaseConnector();
  @override
  final GroupLabelDatabaseConnector groupLabel = GroupLabelDatabaseConnector();

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
    return migrateDatabase(this, db, oldVersion, newVersion);
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
          List.generate(8, (i) => random.nextInt(256)));
  return uuid;
}

Uint8List createEmptyUint8List() {
  return Uint8List(0);
}

bool equalUint8List(Uint8List? a, Uint8List? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

abstract class DatabaseModelConnector<I, C> extends ModelConnector<I, C>
    with TableService {
  String get tableName;
  String get connectedTableName;
  String get connectedIdName;
  String get itemTableName;
  String get itemIdName;
  bool get usesPermission => false;

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        $itemIdName BLOB(16) NOT NULL,
        $connectedIdName BLOB(16) NOT NULL,
        ${usesPermission ? 'permission INTEGER NOT NULL DEFAULT 0,' : ''}
        PRIMARY KEY ($connectedIdName, $itemIdName),
        FOREIGN KEY ($connectedIdName) REFERENCES $connectedTableName(id) ON DELETE CASCADE,
        FOREIGN KEY ($itemIdName) REFERENCES $itemTableName(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<void> connect(Uint8List connectId, Uint8List itemId,
      [ModelPermission? permission]) async {
    if (await isConnected(connectId, itemId)) return;
    permission ??= ModelPermission.read;
    await db?.insert(tableName, {
      itemIdName: itemId,
      connectedIdName: connectId,
      if (usesPermission) 'permission': permission.index,
    });
  }

  @override
  Future<void> disconnect(Uint8List connectId, Uint8List itemId) async {
    await db?.delete(
      tableName,
      where: '$itemIdName = ? AND $connectedIdName = ?',
      whereArgs: [itemId, connectId],
    );
  }

  @override
  Future<bool> isConnected(Uint8List connectId, Uint8List itemId) async {
    final result = await db?.query(
      tableName,
      where: '$itemIdName = ? AND $connectedIdName = ?',
      whereArgs: [itemId, connectId],
      limit: 1,
    );
    return result?.isNotEmpty == true;
  }

  Future<ModelPermission?> getPermission(
      Uint8List connectId, Uint8List itemId) async {
    if (!usesPermission) return null;
    final result = await db?.query(
      tableName,
      columns: ['permission'],
      where: '$itemIdName = ? AND $connectedIdName = ?',
      whereArgs: [itemId, connectId],
      limit: 1,
    );
    if (result?.isEmpty == true) return null;
    final permission = result!.first['permission'] as int;
    return ModelPermission.values[permission];
  }
}
