import 'dart:async';
import 'dart:typed_data';

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
  Future<void> create(DatabaseExecutor db,
      [String name = 'calendarItems']) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $name (
        runtimeType VARCHAR(20) NOT NULL DEFAULT 'fixed',
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT NOT NULL DEFAULT '',
        location VARCHAR(100) NOT NULL DEFAULT '',
        eventId BLOB(16),
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
  Future<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Uint8List? eventId,
    List<Uint8List>? groupIds,
    List<Uint8List>? resourceIds,
    bool pending = false,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  }) async {
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
      var endCalendarItem = startCalendarItem.add(
        const Duration(hours: 23, minutes: 59, seconds: 59),
      );
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
    if (groupIds != null) {
      final placeholders = List.filled(groupIds.length, '?').join(', ');
      final statement =
          "(calendarItems.id IN (SELECT itemId FROM calendarItemGroups WHERE groupId IN ($placeholders)) OR "
          "calendarItems.eventId IN (SELECT eventId FROM eventGroups WHERE groupId IN ($placeholders)))";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, ...groupIds, ...groupIds];
    }
    if (eventId != null) {
      where = where == null ? 'eventId = ?' : '$where AND eventId = ?';
      whereArgs = [...?whereArgs, eventId];
    }
    if (resourceIds != null) {
      final placeholders = List.filled(resourceIds.length, '?').join(', ');
      final statement =
          "(calendarItems.id IN (SELECT itemId FROM calendarItemResources WHERE resourceId IN ($placeholders)) OR "
          "calendarItems.eventId IN (SELECT eventId FROM eventResources WHERE resourceId IN ($placeholders)))";
      where = where == null ? statement : '$where AND $statement';
      whereArgs = [...?whereArgs, ...resourceIds, ...resourceIds];
    }

    const eventPrefix = "event_";
    final result = await db?.query(
      "calendarItems LEFT JOIN events ON events.id = calendarItems.eventId",
      columns: [
        "events.id AS ${eventPrefix}id",
        "events.parentId AS ${eventPrefix}parentId",
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
    return result
            ?.map(
              (e) => ConnectedModel<CalendarItem, Event?>(
                CalendarItem.fromDatabase(e),
                e['${eventPrefix}id'] == null
                    ? null
                    : Event.fromDatabase(
                        Map.fromEntries(e.entries
                            .where(
                              (element) => element.key.startsWith(eventPrefix),
                            )
                            .map(
                              (el) => MapEntry(
                                el.key.substring(eventPrefix.length),
                                el.value,
                              ),
                            )),
                      ),
              ),
            )
            .toList() ??
        [];
  }

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    final id = item.id ?? createUniqueUint8List();
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
          whereArgs: [item.id],
        ) ==
        1;
  }

  @override
  Future<bool> deleteCalendarItem(Uint8List id) async {
    return await db?.delete(
          'calendarItems',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  FutureOr<CalendarItem?> getCalendarItem(Uint8List id) async {
    final result = await db?.query(
      'calendarItems',
      where: 'id = ?',
      whereArgs: [id],
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
  FutureOr<CalendarItem?> getCalendarItem(Uint8List id) =>
      service.getCalendarItem(id);

  @override
  FutureOr<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Uint8List? eventId,
    List<Uint8List>? groupIds,
    List<Uint8List>? resourceIds,
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
        groupIds: groupIds,
        resourceIds: resourceIds,
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
  FutureOr<bool> deleteCalendarItem(Uint8List id) =>
      service.deleteCalendarItem(id);

  @override
  FutureOr<void> clear() => service.clear();
}
