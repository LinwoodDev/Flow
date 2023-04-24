import 'dart:async';

import 'package:collection/collection.dart';
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
    final id = await db?.insert('events', event.toDatabase());
    if (id == null) return null;
    return event.copyWith(id: id.toString());
  }

  @override
  Future<bool> deleteEvent(String id) async {
    return await db?.delete('events', where: 'id = ?', whereArgs: [id]) == 1;
  }

  @override
  Future<Event?> getEvent(String id) async {
    final result = await db?.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Event.fromDatabase).firstOrNull;
  }

  @override
  Future<List<Event>> getEvents(
      {String? groupId,
      String? placeId,
      int offset = 0,
      int limit = 50,
      String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
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
          whereArgs: [event.id],
        ) ==
        1;
  }
}
