import 'dart:async';

import 'package:shared/helpers/date_time.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../services/database.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';
import 'service.dart';

class CalendarItemDatabaseService extends CalendarItemService
    with TableService {
  CalendarItemDatabaseService();

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS calendarItems (
        runtimeType VARCHAR(20) NOT NULL DEFAULT 'fixed',
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location VARCHAR(100) NOT NULL DEFAULT '',
        eventId INTEGER,
        start INTEGER,
        end INTEGER,
        status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
        repeatType VARCHAR(20) NOT NULL DEFAULT 'daily',
        interval INTEGER NOT NULL DEFAULT 1,
        variation INTEGER NOT NULL DEFAULT 0,
        count INTEGER NOT NULL DEFAULT 0,
        until INTEGER,
        exceptions TEXT,
        autoGroupId INTEGER,
        searchStart INTEGER,
        autoDuration INTEGER NOT NULL DEFAULT 60,
        FOREIGN KEY (eventId) REFERENCES events(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  Future<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems(
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
      var startCalendarItem = date.onlyDate();
      var endCalendarItem =
          startCalendarItem.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))'
          : '$where AND (start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))';
      whereArgs = whereArgs == null
          ? [
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
            ]
          : [
              ...whereArgs,
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
              startCalendarItem.secondsSinceEpoch,
              endCalendarItem.secondsSinceEpoch,
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
    if (eventId != null) {
      where = where == null ? 'eventId = ?' : '$where AND eventId = ?';
      whereArgs = whereArgs == null ? [eventId] : [...whereArgs, eventId];
    }
    final result = await db?.query(
      "calendarItems LEFT JOIN events ON events.id = calendarItems.eventId",
      columns: [
        "events.*",
        "calendarItems.runtimeType AS calendarItemruntimeType",
        "calendarItems.id AS calendarItemid",
        "calendarItems.name AS calendarItemname",
        "calendarItems.description AS calendarItemdescription",
        "calendarItems.location AS calendarItemlocation",
        "calendarItems.eventId AS calendarItemeventId",
        "calendarItems.start AS calendarItemstart",
        "calendarItems.end AS calendarItemend",
        "calendarItems.status AS calendarItemstatus",
        "calendarItems.repeatType AS calendarItemrepeatType",
        "calendarItems.interval AS calendarIteminterval",
        "calendarItems.variation AS calendarItemvariation",
        "calendarItems.count AS calendarItemcount",
        "calendarItems.until AS calendarItemuntil",
        "calendarItems.exceptions AS calendarItemexceptions",
        "calendarItems.autoGroupId AS calendarItemautoGroupId",
        "calendarItems.searchStart AS calendarItemsearchStart",
        "calendarItems.autoDuration AS calendarItemautoDuration",
      ],
      where: where,
      whereArgs: whereArgs,
    );
    return result?.map((e) {
          return ConnectedModel<CalendarItem, Event?>(
            CalendarItem.fromJson(Map.fromEntries(e.entries
                .where((element) => element.key.startsWith('calendarItem'))
                .map((e) => MapEntry(
                    e.key.substring("calendarItem".length), e.value)))),
            e['id'] == null ? null : Event.fromDatabase(e),
          );
        }).toList() ??
        [];
  }

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    final id = await db?.insert('calendarItems', item.toJson()..remove('id'));
    if (id == null) return null;
    return item.copyWith(id: id);
  }

  @override
  Future<bool> updateCalendarItem(CalendarItem item) async {
    return await db?.update(
          'calendarItems',
          item.toJson(),
          where: 'id = ?',
          whereArgs: [item.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteCalendarItem(int id) async {
    return await db?.delete(
          'calendarItems',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<CalendarItem?> getCalendarItem(int id) async {
    final result = await db?.query(
      'calendarItems',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(CalendarItem.fromJson).first;
  }

  @override
  Future<void> clear() async {
    await db?.delete('calendarItems');
  }
}

abstract class CalendarItemDatabaseServiceLinker extends CalendarItemService
    with TableService {
  final CalendarItemDatabaseService service;

  CalendarItemDatabaseServiceLinker(this.service);

  @override
  FutureOr<CalendarItem?> getCalendarItem(int id) =>
      service.getCalendarItem(id);

  @override
  FutureOr<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    int? eventId,
    int? groupId,
    int? placeId,
    bool pending = false,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  }) =>
      service.getCalendarItems(
        status: status,
        eventId: eventId,
        groupId: groupId,
        placeId: placeId,
        pending: pending,
        offset: offset,
        limit: limit,
        start: start,
        end: end,
        date: date,
        search: search,
      );

  @override
  FutureOr<CalendarItem?> createCalendarItem(CalendarItem item) =>
      service.createCalendarItem(item);

  @override
  FutureOr<bool> updateCalendarItem(CalendarItem item) =>
      service.updateCalendarItem(item);

  @override
  FutureOr<bool> deleteCalendarItem(int id) => service.deleteCalendarItem(id);

  @override
  FutureOr<void> clear() => service.clear();
}
