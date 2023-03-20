import 'dart:async';

import 'package:collection/collection.dart';
import 'package:shared/helpers/date_time.dart';
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
        id INTEGER PRIMARY KEY,
        parentId INTEGER,
        groupId INTEGER,
        placeId INTEGER,
        blocked INTEGER NOT NULL DEFAULT 1,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location TEXT NOT NULL DEFAULT '',
        placeId INTEGER
      )
    """);
  }

  @override
  Future<Event?> createEvent(Event event) async {
    final id = await db?.insert('events', _encode(event)..remove('id'));
    if (id == null) return null;
    return event.copyWith(id: id);
  }

  @override
  Future<bool> deleteEvent(int id) async {
    return await db?.delete('events', where: 'id = ?', whereArgs: [id]) == 1;
  }

  @override
  Future<Event?> getEvent(int id) async {
    final result = await db?.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(_decode).firstOrNull;
  }

  @override
  Future<List<Event>> getEvents(
      {int? groupId,
      int? placeId,
      int offset = 0,
      int limit = 50,
      String search = ''}) async {
    final where = search.isEmpty ? null : 'name LIKE ?';
    final whereArgs = search.isEmpty ? null : ['%$search%'];
    final result = await db?.query(
      'groups',
      limit: limit,
      offset: offset,
      where: where,
      whereArgs: whereArgs,
    );
    if (result == null) return [];
    return result.map(_decode).toList();
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<bool> updateEvent(Event event) async {
    return await db?.update(
          'events',
          _encode(event),
          where: 'id = ?',
          whereArgs: [event.id],
        ) ==
        1;
  }

  Event _decode(Map<String, dynamic> row) {
    return Event.fromJson({
      ...row,
      'blocked': row['blocked'] == 1,
    });
  }

  Map<String, dynamic> _encode(Event event) {
    return {
      ...event.toJson(),
      'blocked': event.blocked ? 1 : 0,
    };
  }
}

class AppointmentDatabaseService extends AppointmentService with TableService {
  AppointmentDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS eventAppointments (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        eventId INTEGER,
        start INTEGER,
        end INTEGER,
        status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
        timeType VARCHAR(20) NOT NULL DEFAULT 'fixed',
        repeatType VARCHAR(20) NOT NULL DEFAULT 'daily',
        interval INTEGER NOT NULL DEFAULT 1,
        variation INTEGER NOT NULL DEFAULT 0,
        count INTEGER NOT NULL DEFAULT 0,
        until INTEGER,
        exceptions TEXT,
        autoGroupId INTEGER NOT NULL DEFAULT -1,
        searchStart INTEGER,
        autoDuration INTEGER NOT NULL DEFAULT 60
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<Appointment>> getAppointments(
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
      var startAppointment = date.onlyDate();
      var endAppointment =
          startAppointment.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))'
          : '$where AND (start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))';
      whereArgs = whereArgs == null
          ? [
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
            ]
          : [
              ...whereArgs,
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
              startAppointment.secondsSinceEpoch,
              endAppointment.secondsSinceEpoch,
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

    final result = await db?.query('eventAppointments',
        where: where, whereArgs: whereArgs, offset: offset, limit: limit);
    return result?.map(Appointment.fromJson).toList() ?? [];
  }

  @override
  Future<Appointment?> createAppointment(Appointment appointment) async {
    final id = await db?.insert(
        'eventAppointments', appointment.toJson()..remove('id'));
    if (id == null) return null;
    return appointment.copyWith(id: id);
  }

  @override
  Future<bool> updateAppointment(Appointment appointment) async {
    return await db?.update(
          'eventAppointments',
          appointment.toJson(),
          where: 'id = ?',
          whereArgs: [appointment.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteAppointment(int id) async {
    return await db?.delete(
          'eventAppointments',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<Appointment?> getAppointment(int id) async {
    final result = await db?.query(
      'eventAppointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Appointment.fromJson).first;
  }

  @override
  Future<void> clear() async {
    await db?.delete('eventAppointments');
  }
}
