import 'dart:async';

import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

class EventDatabaseService extends EventService implements TableService {
  @override
  final Database db;

  EventDatabaseService(this.db);

  @override
  Future<void> create() {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY,
        groupId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        location TEXT,
        placeId INTEGER,
        start TEXT,
        end TEXT,
        status TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(int version) {}

  @override
  Future<List<Event>> getEvents({EventStatus? status}) async {
    String? where;
    List<Object?>? whereArgs;
    if (status != null) {
      where = 'status = ?';
      whereArgs = [status.toString()];
    }
    final result = await db.query('events', where: where, whereArgs: whereArgs);
    return result.map((row) => Event.fromJson(row)).toList();
  }
}

class EventGroupDatabaseService extends EventGroupService with TableService {
  @override
  final Database db;

  EventGroupDatabaseService(this.db);

  @override
  Future<void> create() {
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
  FutureOr<void> migrate(int version) {}

  @override
  Future<List<EventGroup>> getGroups() async {
    final result = await db.query('eventGroups');
    return result.map((row) => EventGroup.fromJson(row)).toList();
  }
}
