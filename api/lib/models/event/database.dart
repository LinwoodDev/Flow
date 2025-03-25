import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flow_api/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class EventDatabaseService extends EventService with TableService {
  @override
  Future<void> clear() async {
    await db?.delete('events');
  }

  @override
  FutureOr<void> create(DatabaseExecutor db, [String name = 'events']) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $name (
        id BLOB(16) PRIMARY KEY,
        parentId BLOB(16),
        blocked INTEGER NOT NULL DEFAULT 1,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location TEXT NOT NULL DEFAULT '',
        extra TEXT,
        FOREIGN KEY (parentId) REFERENCES events(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<Event?> createEvent(Event event) async {
    final id = event.id ?? createUniqueUint8List();
    event = event.copyWith(id: id);
    final row = await db?.insert('events', event.toDatabase());
    if (row == null) return null;
    return event;
  }

  @override
  Future<bool> deleteEvent(Uint8List id) async {
    return await db?.delete('events', where: 'id = ?', whereArgs: [id]) == 1;
  }

  @override
  Future<Event?> getEvent(Uint8List id) async {
    final result = await db?.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Event.fromDatabase).firstOrNull;
  }

  @override
  Future<List<Event>> getEvents(
      {Uint8List? groupId,
      List<Uint8List>? resourceIds,
      int offset = 0,
      int limit = 50,
      String search = ''}) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$search%'];
    }
    if (groupId != null) {
      final statement =
          "id IN (SELECT eventId FROM eventGroups WHERE groupId = ?)";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, groupId];
    }
    if (resourceIds != null) {
      final statement =
          "id IN (SELECT itemId FROM eventResources WHERE resourceId IN (${resourceIds.map((e) => '?').join(', ')}))";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, ...resourceIds];
    }
    final result = await db?.query(
      'events',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map(Event.fromDatabase).toList();
  }

  @override
  FutureOr<bool> updateEvent(Event event) async {
    return await db?.update(
          'events',
          event.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [event.id],
        ) ==
        1;
  }
}
