import 'dart:async';

import 'package:shared/helpers/date_time.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../services/database.dart';
import '../model.dart';
import 'model.dart';
import 'service.dart';

class AppointmentDatabaseService extends AppointmentService with TableService {
  AppointmentDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS appointments (
        runtimeType VARCHAR(20) NOT NULL DEFAULT 'fixed',
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        eventId INTEGER NOT NULL,
        start INTEGER,
        end INTEGER,
        status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
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
      int? eventId,
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
    if (eventId != null) {
      where = where == null ? 'eventId = ?' : '$where AND eventId = ?';
      whereArgs = whereArgs == null ? [eventId] : [...whereArgs, eventId];
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

    final result = await db?.query('appointments',
        where: where, whereArgs: whereArgs, offset: offset, limit: limit);
    return result?.map(Appointment.fromJson).toList() ?? [];
  }

  @override
  Future<Appointment?> createAppointment(Appointment appointment) async {
    final id =
        await db?.insert('appointments', appointment.toJson()..remove('id'));
    if (id == null) return null;
    return appointment.copyWith(id: id);
  }

  @override
  Future<bool> updateAppointment(Appointment appointment) async {
    return await db?.update(
          'appointments',
          appointment.toJson(),
          where: 'id = ?',
          whereArgs: [appointment.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteAppointment(int id) async {
    return await db?.delete(
          'appointments',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<Appointment?> getAppointment(int id) async {
    final result = await db?.query(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Appointment.fromJson).first;
  }

  @override
  Future<void> clear() async {
    await db?.delete('appointments');
  }
}

class AppointmentEventDatabaseConnector extends AppointmentEventConnector
    with TableService {
  @override
  Future<List<Appointment>> getAppointments(
      {List<EventStatus>? status,
      int offset = 0,
      int limit = 50,
      DateTime? start,
      DateTime? end,
      DateTime? date,
      String search = '',
      int? groupId,
      int? placeId}) async {
    String? where;
    List<Object?>? whereArgs;
    if (status != null) {
      where = 'status IN (${status.map((e) => '?').join(', ')})';
      whereArgs = status.map((e) => e.name).toList();
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
    if (groupId != null) {
      where = where == null ? 'groupId = ?' : '$where AND groupId = ?';
      whereArgs = whereArgs == null ? [groupId] : [...whereArgs, groupId];
    }
    if (placeId != null) {
      where = where == null ? 'placeId = ?' : '$where AND placeId = ?';
      whereArgs = whereArgs == null ? [placeId] : [...whereArgs, placeId];
    }
    final result = await db?.rawQuery(
      "SELECT * FROM appointments INNER JOIN events ON events.id = appointments.eventId WHERE $where",
      whereArgs,
    );
    return result?.map(Appointment.fromJson).toList() ?? [];
  }
}
