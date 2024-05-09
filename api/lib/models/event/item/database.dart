import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:dart_leap/dart_leap.dart';
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
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location VARCHAR(100) NOT NULL DEFAULT '',
        eventId BLOB(16),
        groupId BLOB(16),
        placeId BLOB(16),
        start INTEGER,
        end INTEGER,
        status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
        repeatType VARCHAR(20) NOT NULL DEFAULT 'daily',
        interval INTEGER NOT NULL DEFAULT 1,
        variation INTEGER NOT NULL DEFAULT 0,
        count INTEGER NOT NULL DEFAULT 0,
        until INTEGER,
        exceptions TEXT,
        autoGroupId BLOB(16),
        searchStart INTEGER,
        autoDuration INTEGER NOT NULL DEFAULT 60,
        FOREIGN KEY (eventId) REFERENCES events(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<void> migrate(Database db, int version) async {
    if (version < 3) {
      await db.transaction((txn) async {
        await txn.execute("ALTER TABLE calendarItems ADD groupId BLOB(16)");
        await txn.execute("ALTER TABLE calendarItems ADD placeId BLOB(16)");
      });
    }
  }

  @override
  Future<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems(
      {List<EventStatus>? status,
      Multihash? eventId,
      Multihash? groupId,
      Multihash? placeId,
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
      whereArgs = [...?whereArgs, start.secondsSinceEpoch];
    }
    if (end != null) {
      where = where == null ? 'end <= ?' : '$where AND end <= ?';
      whereArgs = [...?whereArgs, end.secondsSinceEpoch];
    }
    if (date != null) {
      var startCalendarItem = date.onlyDate();
      var endCalendarItem =
          startCalendarItem.add(Duration(hours: 23, minutes: 59, seconds: 59));
      where = where == null
          ? '(start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))'
          : '$where AND (start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))';
      whereArgs = [
        ...?whereArgs,
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
      whereArgs = [...?whereArgs, '%$search%', '%$search%'];
    }
    if (groupId != null) {
      final statement = "(groupId = ? OR events.groupId = ?)";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, groupId.fullBytes, groupId.fullBytes];
    }
    if (placeId != null) {
      final statement = "(placeId = ? OR events.placeId = ?)";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, placeId.fullBytes, placeId.fullBytes];
    }
    if (eventId != null) {
      where = where == null ? 'eventId = ?' : '$where AND eventId = ?';
      whereArgs = [...?whereArgs, eventId.fullBytes];
    }
    const eventPrefix = "event_";
    final result = await db?.query(
      "calendarItems LEFT JOIN events ON events.id = calendarItems.eventId",
      columns: [
        "events.id AS ${eventPrefix}id",
        "events.parentId AS ${eventPrefix}parentId",
        "events.groupId AS ${eventPrefix}groupId",
        "events.placeId AS ${eventPrefix}placeId",
        "events.blocked AS ${eventPrefix}blocked",
        "events.name AS ${eventPrefix}name",
        "events.description AS ${eventPrefix}description",
        "events.location AS ${eventPrefix}location",
        "events.extra AS ${eventPrefix}extra",
        "calendarItems.*",
      ],
      where: where,
      whereArgs: whereArgs,
    );
    return result?.map((e) {
          return ConnectedModel<CalendarItem, Event?>(
            CalendarItem.fromDatabase(e),
            e['${eventPrefix}id'] == null
                ? null
                : Event.fromDatabase(Map.fromEntries(e.entries
                    .where((element) => element.key.startsWith(eventPrefix))
                    .map((e) => MapEntry(
                        e.key.substring(eventPrefix.length), e.value)))),
          );
        }).toList() ??
        [];
  }

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    final id = item.id ?? createUniqueMultihash();
    item = item.copyWith(id: id);
    final row = await db?.insert('calendarItems', item.toDatabase());
    if (row == null) return null;
    return item;
  }

  @override
  Future<bool> updateCalendarItem(CalendarItem item) async {
    return await db?.update(
          'calendarItems',
          item.toDatabase(),
          where: 'id = ?',
          whereArgs: [item.id?.fullBytes],
        ) ==
        1;
  }

  @override
  Future<bool> deleteCalendarItem(Multihash id) async {
    return await db?.delete(
          'calendarItems',
          where: 'id = ?',
          whereArgs: [id.fullBytes],
        ) ==
        1;
  }

  @override
  FutureOr<CalendarItem?> getCalendarItem(Multihash id) async {
    final result = await db?.query(
      'calendarItems',
      where: 'id = ?',
      whereArgs: [id.fullBytes],
    );
    return result?.map(CalendarItem.fromDatabase).first;
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
  FutureOr<CalendarItem?> getCalendarItem(Multihash id) =>
      service.getCalendarItem(id);

  @override
  FutureOr<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Multihash? eventId,
    Multihash? groupId,
    Multihash? placeId,
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
  FutureOr<bool> deleteCalendarItem(Multihash id) =>
      service.deleteCalendarItem(id);

  @override
  FutureOr<void> clear() => service.clear();
}
