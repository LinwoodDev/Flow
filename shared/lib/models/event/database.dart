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
  Future<bool> deleteEvent(int id) async {
    return await db?.delete(
          'events',
          where: 'id = ?',
          whereArgs: [id],
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

class EventTodoDatabaseService extends EventTodoService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS eventTodos (
        id INTEGER PRIMARY KEY,
        eventId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        done INTEGER NOT NULL DEFAULT 0
      )
    """);
  }

  @override
  Future<EventTodo?> createTodo(EventTodo todo) async {
    final id = await db?.insert(
        'eventTodos',
        todo.toJson()
          ..remove('id')
          ..['done'] = todo.done ? 1 : 0);
    if (id == null) return null;
    return todo.copyWith(id: id);
  }

  @override
  Future<bool> deleteTodo(int id) async {
    return await db?.delete(
          'eventTodos',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<EventTodo>> getTodos(
      {int? eventId, int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      'eventTodos',
      where: eventId == null ? null : 'eventId = ?',
      whereArgs: eventId == null ? null : [eventId],
      offset: offset,
      limit: limit,
    );
    return result
            ?.map((row) =>
                EventTodo.fromJson(Map.from(row)..['done'] = row['done'] == 1))
            .toList() ??
        [];
  }

  @override
  Future<bool?> todosDone(int eventId) async {
    final result = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM eventTodos WHERE eventId = ? AND done = 1',
        [eventId]);
    final resultCount = result?.first['count'] as int? ?? 0;
    final all = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM eventTodos WHERE eventId = ?',
        [eventId]);
    final allCount = all?.first['count'] as int? ?? 0;
    if (resultCount == allCount && allCount > 0) {
      return true;
    }
    if (resultCount == 0 && allCount > 0) {
      return false;
    }
    return null;
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<bool> updateTodo(EventTodo todo) async {
    return await db?.update(
          'eventTodos',
          todo.toJson()
            ..remove('id')
            ..['done'] = todo.done ? 1 : 0,
          where: 'id = ?',
          whereArgs: [todo.id],
        ) ==
        1;
  }
}
