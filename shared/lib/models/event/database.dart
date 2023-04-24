import 'dart:async';

import 'package:collection/collection.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class EventDatabaseService extends EventService with TableService {
  @override
  Future<void> clear() async {
    await db?.delete('events');
  }

  @override
  FutureOr<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS events (
        id BLOB(16) PRIMARY KEY,
        parentId BLOB(16),
        groupId BLOB(16),
        placeId BLOB(16),
        blocked INTEGER NOT NULL DEFAULT 1,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location TEXT NOT NULL DEFAULT '',
        FOREIGN KEY (parentId) REFERENCES events(id) ON DELETE CASCADE,
        FOREIGN KEY (groupId) REFERENCES groups(id) ON DELETE CASCADE,
        FOREIGN KEY (placeId) REFERENCES places(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<Event?> createEvent(Event event) async {
    final id = event.id ?? createUniqueMultihash();
    event = event.copyWith(id: id);
    final row = await db?.insert('events', event.toDatabase());
    if (row == null) return null;
    return event;
  }

  @override
  Future<bool> deleteEvent(Multihash id) async {
    return await db
            ?.delete('events', where: 'id = ?', whereArgs: [id.fullBytes]) ==
        1;
  }

  @override
  Future<Event?> getEvent(Multihash id) async {
    final result = await db?.query(
      'events',
      where: 'id = ?',
      whereArgs: [id.fullBytes],
    );
    return result?.map(Event.fromDatabase).firstOrNull;
  }

  @override
  Future<List<Event>> getEvents(
      {Multihash? groupId,
      Multihash? placeId,
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
      where = where == null ? 'groupId = ?' : '$where AND groupId = ?';
      whereArgs = whereArgs == null
          ? [groupId.fullBytes]
          : [...whereArgs, groupId.fullBytes];
    }
    if (placeId != null) {
      where = where == null ? 'placeId = ?' : '$where AND placeId = ?';
      whereArgs = whereArgs == null
          ? [placeId.fullBytes]
          : [...whereArgs, placeId.fullBytes];
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
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<bool> updateEvent(Event event) async {
    return await db?.update(
          'events',
          event.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [event.id?.fullBytes],
        ) ==
        1;
  }
}
