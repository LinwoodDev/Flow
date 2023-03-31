import 'dart:async';

import 'package:shared/helpers/date_time.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../services/database.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';
import 'service.dart';

class MomentDatabaseService extends MomentService with TableService {
  MomentDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS moments (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location VARCHAR(100) NOT NULL DEFAULT '',
        eventId INTEGER NOT NULL,
        status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
        time INTEGER
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<Moment>> getMoments(
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
      where = where == null ? 'time >= ?' : '$where AND time >= ?';
      whereArgs = whereArgs == null
          ? [start.secondsSinceEpoch]
          : [...whereArgs, start.secondsSinceEpoch];
    }
    if (end != null) {
      where = where == null ? 'time <= ?' : '$where AND time <= ?';
      whereArgs = whereArgs == null
          ? [end.secondsSinceEpoch]
          : [...whereArgs, end.secondsSinceEpoch];
    }
    if (date != null) {
      var startMoment = date.onlyDate();
      var endMoment =
          startMoment.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(time BETWEEN ? AND ? OR (time <= ? AND time >= ?))'
          : '$where AND (time BETWEEN ? AND ? OR (time <= ? AND time >= ?))';
      whereArgs = whereArgs == null
          ? [
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
            ]
          : [
              ...whereArgs,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
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

    final result = await db?.query('moments',
        where: where, whereArgs: whereArgs, offset: offset, limit: limit);
    return result?.map(Moment.fromJson).toList() ?? [];
  }

  @override
  Future<Moment?> createMoment(Moment moment) async {
    final id = await db?.insert('moments', moment.toJson()..remove('id'));
    if (id == null) return null;
    return moment.copyWith(id: id);
  }

  @override
  Future<bool> updateMoment(Moment moment) async {
    return await db?.update(
          'moments',
          moment.toJson(),
          where: 'id = ?',
          whereArgs: [moment.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteMoment(int id) async {
    return await db?.delete(
          'moments',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<Moment?> getMoment(int id) async {
    final result = await db?.query(
      'moments',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Moment.fromJson).first;
  }

  @override
  Future<void> clear() async {
    await db?.delete('moments');
  }
}

class MomentEventDatabaseConnector extends MomentEventConnector
    with TableService {
  @override
  Future<List<ConnectedModel<Moment, Event>>> getMoments(
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
      where = where == null ? 'time >= ?' : '$where AND time >= ?';
      whereArgs = whereArgs == null
          ? [start.secondsSinceEpoch]
          : [...whereArgs, start.secondsSinceEpoch];
    }
    if (end != null) {
      where = where == null ? 'time <= ?' : '$where AND time <= ?';
      whereArgs = whereArgs == null
          ? [end.secondsSinceEpoch]
          : [...whereArgs, end.secondsSinceEpoch];
    }
    if (date != null) {
      var startMoment = date.onlyDate();
      var endMoment =
          startMoment.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(time BETWEEN ? AND ? OR (time <= ? AND time >= ?))'
          : '$where AND (time BETWEEN ? AND ? OR (time <= ? AND time >= ?))';
      whereArgs = whereArgs == null
          ? [
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
            ]
          : [
              ...whereArgs,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
              startMoment.secondsSinceEpoch,
              endMoment.secondsSinceEpoch,
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
    final result = await db?.query(
      "moments INNER JOIN events ON events.id = moments.eventId",
      columns: [
        "events.*",
        "moments.id AS momentid",
        "moments.name AS momentname",
        "moments.description AS momentdescription",
        "moments.location AS momentlocation",
        "moments.eventId AS momenteventId",
        "moments.status AS momentstatus",
        "moments.time AS momenttime",
      ],
      where: where,
      whereArgs: whereArgs,
    );
    return result?.map((e) {
          return ConnectedModel<Moment, Event>(
            Moment.fromJson(Map.fromEntries(e.entries
                .where((element) => element.key.startsWith('moment'))
                .map((e) =>
                    MapEntry(e.key.substring('moment'.length), e.value)))),
            Event.fromDatabase(e),
          );
        }).toList() ??
        [];
  }
}
