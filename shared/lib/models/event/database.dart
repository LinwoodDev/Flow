import 'dart:async';

import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class EventDatabaseService extends EventService with TableService {
  EventDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY,
        groupId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        location TEXT,
        placeId INTEGER,
        start INTEGER,
        end INTEGER,
        status TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<Event>> getEvents({EventStatus? status}) async {
    String? where;
    List<Object?>? whereArgs;
    if (status != null) {
      where = 'status = ?';
      whereArgs = [status.toString()];
    }
    final result =
        await db?.query('events', where: where, whereArgs: whereArgs);
    return result?.map((row) => Event.fromJson(row)).toList() ?? [];
  }

  @override
  Future<Event?> createEvent(Event event) async {
    final id = await db?.insert('events', event.toJson()..remove('id'));
    if (id == null) return null;
    return event.copyWith(id: id);
  }

  @override
  Future<bool> updateEvent(Event event) async {
    return await db?.update(
          'events',
          event.toJson(),
          where: 'id = ?',
          whereArgs: [event.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteEvent(Event event) async {
    return await db?.delete(
          'events',
          where: 'id = ?',
          whereArgs: [event.id],
        ) ==
        1;
  }
}

class EventGroupDatabaseService extends EventGroupService with TableService {
  EventGroupDatabaseService();

  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS eventGroups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        image TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<EventGroup>> getGroups() async {
    final result = await db?.query('eventGroups');
    return result?.map((row) => EventGroup.fromJson(row)).toList() ?? [];
  }
}
