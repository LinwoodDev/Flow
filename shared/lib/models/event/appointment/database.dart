import 'dart:async';

import 'package:shared/helpers/date_time.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../services/database.dart';
import '../../model.dart';
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
        location VARCHAR(100) NOT NULL DEFAULT '',
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
  Future<List<ConnectedModel<Appointment, Event>>> getAppointments(
      {List<EventStatus>? status,
      int? eventId,
      int? groupId,
      int? placeId,
      bool pending = false,
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
    if (pending) {
      where = where == null
          ? '(start IS NULL AND end IS NULL)'
          : '$where AND (start IS NULL AND end IS NULL)';
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
    final result = await db?.query(
      "appointments INNER JOIN events ON events.id = appointments.eventId",
      columns: [
        "events.*",
        "appointments.runtimeType AS appointmentruntimeType",
        "appointments.id AS appointmentid",
        "appointments.name AS appointmentname",
        "appointments.description AS appointmentdescription",
        "appointments.location AS appointmentlocation",
        "appointments.eventId AS appointmenteventId",
        "appointments.start AS appointmentstart",
        "appointments.end AS appointmentend",
        "appointments.status AS appointmentstatus",
        "appointments.repeatType AS appointmentrepeatType",
        "appointments.interval AS appointmentinterval",
        "appointments.variation AS appointmentvariation",
        "appointments.count AS appointmentcount",
        "appointments.until AS appointmentuntil",
        "appointments.exceptions AS appointmentexceptions",
        "appointments.autoGroupId AS appointmentautoGroupId",
        "appointments.searchStart AS appointmentsearchStart",
        "appointments.autoDuration AS appointmentautoDuration",
      ],
      where: where,
      whereArgs: whereArgs,
    );
    return result?.map((e) {
          return ConnectedModel<Appointment, Event>(
            Appointment.fromJson(Map.fromEntries(e.entries
                .where((element) => element.key.startsWith('appointment'))
                .map((e) =>
                    MapEntry(e.key.substring("appointment".length), e.value)))),
            Event.fromDatabase(e),
          );
        }).toList() ??
        [];
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
