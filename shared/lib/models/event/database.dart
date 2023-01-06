import 'dart:async';

import 'package:shared/helpers/date_time.dart';
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
  Future<List<Event>> getEvents(
      {List<EventStatus>? status,
      bool pending = false,
      int? groupId,
      int? placeId,
      int offset = 0,
      int limit = 50,
      DateTime? start,
      DateTime? end,
      DateTime? date,
      String search = ''}) async {
    String? where;
    List<Object?>? whereArgs;
    if (status != null) {
      where = 'status IN (${status.map((e) => '?').join(', ')})';
      whereArgs = status.map((e) => e.name).toList();
    }
    if (groupId != null) {
      where = where == null ? 'groupId = ?' : '$where AND groupId = ?';
      whereArgs = whereArgs == null ? [groupId] : [...whereArgs, groupId];
    }
    if (placeId != null) {
      where = where == null ? 'placeId = ?' : '$where AND placeId = ?';
      whereArgs = whereArgs == null ? [placeId] : [...whereArgs, placeId];
    }
    if (start != null) {
      where = where == null ? 'start >= ?' : '$where AND start >= ?';
      whereArgs = whereArgs == null
          ? [start.secondsSinceEpoch]
          : [...whereArgs, start.secondsSinceEpoch];
    }
    if (end != null) {
      where = where == null ? 'end <= ?' : '$where AND end <= ?';
      whereArgs = whereArgs == null
          ? [end.secondsSinceEpoch]
          : [...whereArgs, end.secondsSinceEpoch];
    }
    if (date != null) {
      var startDate = date.onlyDate();
      var endDate =
          startDate.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))'
          : '$where AND (start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))';
      whereArgs = whereArgs == null
          ? [
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
            ]
          : [
              ...whereArgs,
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
              startDate.secondsSinceEpoch,
              endDate.secondsSinceEpoch,
            ];
    }
    if (search.isNotEmpty) {
      where = where == null
          ? '(name LIKE ? OR description LIKE ?)'
          : '$where AND (name LIKE ? OR description LIKE ?)';
      whereArgs = whereArgs == null
          ? ['%$search%', '%$search%']
          : [...whereArgs, '%$search%', '%$search%'];
    }
    if (pending) {
      where = where == null
          ? 'start IS NULL AND end IS NULL'
          : '$where AND start IS NULL AND end IS NULL';
    }

    final result = await db?.query('events',
        where: where, whereArgs: whereArgs, offset: offset, limit: limit);
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
