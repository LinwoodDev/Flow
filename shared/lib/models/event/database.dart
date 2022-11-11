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
  Future<List<Event>> getEvents({List<EventStatus> status = const []}) async {
    String? where;
    List<Object?>? whereArgs;
    if (status.isNotEmpty) {
      where = 'status IN (${status.map((e) => '?').join(', ')})';
      whereArgs = status.map((e) => e.name).toList();
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
  Future<bool> deleteEvent(int id) async {
    return await db?.delete(
          'events',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<Event?> getEvent(int id) async {
    final result = await db?.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map((row) => Event.fromJson(row)).first;
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
        image BLOB,
        open INTEGER NOT NULL DEFAULT 0
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<EventGroup>> getGroups({
    int limit = 50,
    int offset = 0,
  }) async {
    final result = await db?.query('eventGroups', limit: limit, offset: offset);
    return result
            ?.map((row) => EventGroup.fromJson(
                Map<String, dynamic>.from(row)..['open'] = row['open'] == 1))
            .toList() ??
        [];
  }

  @override
  Future<EventGroup?> createGroup(EventGroup group) async {
    final id = await db?.insert(
        'eventGroups',
        group.toJson()
          ..remove('id')
          ..['open'] = group.open ? 1 : 0);
    if (id == null) return null;
    return group.copyWith(id: id);
  }

  @override
  Future<bool> updateGroup(EventGroup group) async {
    return await db?.update(
          'eventGroups',
          group.toJson()..['open'] = group.open ? 1 : 0,
          where: 'id = ?',
          whereArgs: [group.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteGroup(int id) async {
    return await db?.delete(
          'eventGroups',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<EventGroup?> getGroup(int id) async {
    final result = await db?.query(
      'eventGroups',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result
        ?.map((row) => EventGroup.fromJson(row..['open'] = row['open'] == 1))
        .first;
  }
}
