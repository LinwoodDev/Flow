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

  static const _defaultRangeDays = 31;

  @override
  Future<void> create(
    DatabaseExecutor db, [
    String name = 'calendarItems',
  ]) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $name (
        runtimeType VARCHAR(32) NOT NULL DEFAULT 'FixedCalendarItem',
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
    final whereArgs = <Object?>[];
    final hasTemporalFilter = start != null || end != null || date != null;

    if (status != null) {
      where = _addWhere(
        where,
        whereArgs,
        'status IN (${status.map((e) => '?').join(', ')})',
        status.map((e) => e.name),
      );
    }
    if (pending) {
      where = _addWhere(where, whereArgs, '(start IS NULL AND end IS NULL)');
    }
    if (search.isNotEmpty) {
      where = _addWhere(
        where,
        whereArgs,
        '(name LIKE ? OR description LIKE ?)',
        ['%$search%', '%$search%'],
      );
    }
    if (groupIds != null) {
      final placeholders = List.filled(groupIds.length, '?').join(', ');
      final statement =
          "(calendarItems.id IN (SELECT itemId FROM calendarItemGroups WHERE groupId IN ($placeholders)) OR "
          "calendarItems.eventId IN (SELECT eventId FROM eventGroups WHERE groupId IN ($placeholders)))";
      where = _addWhere(where, whereArgs, statement, [
        ...groupIds,
        ...groupIds,
      ]);
    }
    if (eventId != null) {
      where = _addWhere(where, whereArgs, 'eventId = ?', [eventId]);
    }
    if (resourceIds != null) {
      final placeholders = List.filled(resourceIds.length, '?').join(', ');
      final statement =
          "(calendarItems.id IN (SELECT itemId FROM calendarItemResources WHERE resourceId IN ($placeholders)) OR "
          "calendarItems.eventId IN (SELECT eventId FROM eventResources WHERE resourceId IN ($placeholders)))";
      where = _addWhere(where, whereArgs, statement, [
        ...resourceIds,
        ...resourceIds,
      ]);
    }

    if (!hasTemporalFilter) {
      return _queryItems(
        where: where,
        whereArgs: whereArgs,
        offset: offset,
        limit: limit,
      );
    }

    final windowStart =
        date?.onlyDate() ??
        start ??
        end?.subtract(const Duration(days: _defaultRangeDays)) ??
        DateTime.now().subtract(const Duration(days: _defaultRangeDays));
    final windowEnd = date != null
        ? _endOfDay(date)
        : end ??
              start?.add(const Duration(days: _defaultRangeDays)) ??
              DateTime.now().add(const Duration(days: _defaultRangeDays));

    final fixedWhereArgs = <Object?>[...whereArgs];
    var fixedWhere = where;
    fixedWhere = _addWhere(
      fixedWhere,
      fixedWhereArgs,
      '(runtimeType NOT IN (?, ?, ?))',
      const ['RepeatingCalendarItem', 'repeating', 'AutoCalendarItem'],
    );
    fixedWhere = _addWhere(
      fixedWhere,
      fixedWhereArgs,
      '(start BETWEEN ? AND ? OR end BETWEEN ? AND ? OR (start <= ? AND end >= ?))',
      [
        windowStart.secondsSinceEpoch,
        windowEnd.secondsSinceEpoch,
        windowStart.secondsSinceEpoch,
        windowEnd.secondsSinceEpoch,
        windowStart.secondsSinceEpoch,
        windowEnd.secondsSinceEpoch,
      ],
    );

    final repeatingWhereArgs = <Object?>[...whereArgs];
    var repeatingWhere = where;
    repeatingWhere = _addWhere(
      repeatingWhere,
      repeatingWhereArgs,
      '(runtimeType IN (?, ?, ?))',
      const ['RepeatingCalendarItem', 'repeating', 'AutoCalendarItem'],
    );
    // Limit recurrence definitions to rows that can potentially produce
    // occurrences inside the requested window.
    repeatingWhere = _addWhere(
      repeatingWhere,
      repeatingWhereArgs,
      'start IS NOT NULL',
    );
    repeatingWhere = _addWhere(
      repeatingWhere,
      repeatingWhereArgs,
      'start <= ?',
      [windowEnd.secondsSinceEpoch],
    );
    repeatingWhere = _addWhere(
      repeatingWhere,
      repeatingWhereArgs,
      '(until IS NULL OR until >= ?)',
      [windowStart.secondsSinceEpoch],
    );

    final fixedItems = await _queryItems(
      where: fixedWhere,
      whereArgs: fixedWhereArgs,
    );
    final repeatingDefinitions = await _queryItems(
      where: repeatingWhere,
      whereArgs: repeatingWhereArgs,
    );

    final expandedRepeating = repeatingDefinitions.expand(
      (entry) => _expandConnectedForRange(
        entry,
        windowStart,
        windowEnd,
        start: start,
        end: end,
        date: date,
      ),
    );

    final merged = [...fixedItems, ...expandedRepeating]
      ..sort(_compareCalendarItems);

    final startIndex = offset.clamp(0, merged.length);
    final endIndex = (startIndex + limit).clamp(0, merged.length);
    return merged.sublist(startIndex, endIndex);
  }

  String _addWhere(
    String? current,
    List<Object?> whereArgs,
    String clause, [
    Iterable<Object?> args = const [],
  ]) {
    whereArgs.addAll(args);
    return current == null ? clause : '$current AND $clause';
  }

  Future<List<ConnectedModel<CalendarItem, Event?>>> _queryItems({
    String? where,
    List<Object?>? whereArgs,
    int? offset,
    int? limit,
  }) async {
    const eventPrefix = 'event_';
    final result = await db?.query(
      'calendarItems LEFT JOIN events ON events.id = calendarItems.eventId',
      columns: [
        'events.id AS ${eventPrefix}id',
        'events.parentId AS ${eventPrefix}parentId',
        'events.blocked AS ${eventPrefix}blocked',
        'events.name AS ${eventPrefix}name',
        'events.description AS ${eventPrefix}description',
        'events.location AS ${eventPrefix}location',
        'events.extra AS ${eventPrefix}extra',
        'calendarItems.*',
      ],
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
    );

    return result
            ?.map(
              (e) => ConnectedModel<CalendarItem, Event?>(
                CalendarItem.fromDatabase(e),
                e['${eventPrefix}id'] == null
                    ? null
                    : Event.fromDatabase(
                        Map.fromEntries(
                          e.entries
                              .where(
                                (element) =>
                                    element.key.startsWith(eventPrefix),
                              )
                              .map(
                                (el) => MapEntry(
                                  el.key.substring(eventPrefix.length),
                                  el.value,
                                ),
                              ),
                        ),
                      ),
              ),
            )
            .toList() ??
        [];
  }

  int _compareCalendarItems(
    ConnectedModel<CalendarItem, Event?> a,
    ConnectedModel<CalendarItem, Event?> b,
  ) {
    final aStart = a.source.start;
    final bStart = b.source.start;
    if (aStart == null && bStart != null) return 1;
    if (aStart != null && bStart == null) return -1;
    if (aStart != null && bStart != null) {
      final startCmp = aStart.compareTo(bStart);
      if (startCmp != 0) return startCmp;
    }

    final aEnd = a.source.end;
    final bEnd = b.source.end;
    if (aEnd == null && bEnd != null) return 1;
    if (aEnd != null && bEnd == null) return -1;
    if (aEnd != null && bEnd != null) {
      final endCmp = aEnd.compareTo(bEnd);
      if (endCmp != 0) return endCmp;
    }

    return a.source.name.compareTo(b.source.name);
  }

  Iterable<ConnectedModel<CalendarItem, Event?>> _expandConnectedForRange(
    ConnectedModel<CalendarItem, Event?> entry,
    DateTime windowStart,
    DateTime windowEnd, {
    DateTime? start,
    DateTime? end,
    DateTime? date,
  }) sync* {
    final item = entry.source;
    final expanded = item is RepeatingCalendarItem
        ? _expandRepeatingCalendarItem(item, windowStart, windowEnd)
        : [item];

    for (final occurrence in expanded) {
      if (_matchesTemporalFilter(
        occurrence,
        start: start,
        end: end,
        date: date,
      )) {
        yield ConnectedModel(occurrence, entry.model);
      }
    }
  }

  bool _matchesTemporalFilter(
    CalendarItem item, {
    DateTime? start,
    DateTime? end,
    DateTime? date,
  }) {
    if (start != null && (item.start == null || item.start!.isBefore(start))) {
      return false;
    }
    if (end != null && (item.end == null || item.end!.isAfter(end))) {
      return false;
    }
    if (date != null) {
      final dayStart = date.onlyDate();
      final dayEnd = _endOfDay(date);
      if (!_overlapsRange(item.start, item.end, dayStart, dayEnd)) {
        return false;
      }
    }
    return true;
  }

  bool _overlapsRange(
    DateTime? itemStart,
    DateTime? itemEnd,
    DateTime rangeStart,
    DateTime rangeEnd,
  ) {
    return (itemEnd == null || !itemEnd.isBefore(rangeStart)) &&
        (itemStart == null || !itemStart.isAfter(rangeEnd));
  }

  DateTime _endOfDay(DateTime date) =>
      date.onlyDate().add(const Duration(hours: 23, minutes: 59, seconds: 59));

  List<CalendarItem> _expandRepeatingCalendarItem(
    RepeatingCalendarItem item,
    DateTime windowStart,
    DateTime windowEnd,
  ) {
    final baseStart = item.start;
    if (baseStart == null) {
      return [item];
    }
    final baseEnd = item.end;
    final duration = baseEnd?.difference(baseStart) ?? Duration.zero;
    final searchStart = duration > Duration.zero
        ? windowStart.subtract(duration)
        : windowStart;
    return _expandRecurring(
      item,
      repeatType: item.repeatType,
      interval: item.interval,
      count: item.count,
      until: item.until,
      exceptions: item.exceptions,
      baseStart: baseStart,
      duration: duration,
      weeklyWeekdays: item.weeklyWeekdays,
      monthlyMonthDays: item.monthlyMonthDays,
      searchStart: searchStart,
      windowEnd: windowEnd,
    );
  }

  List<CalendarItem> _expandRecurring(
    CalendarItem source, {
    required RepeatType repeatType,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> exceptions,
    required DateTime baseStart,
    required Duration duration,
    required List<int> weeklyWeekdays,
    required List<int> monthlyMonthDays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) {
    final occurrences = <CalendarItem>[];
    final safeInterval = interval <= 0 ? 1 : interval;
    final exceptionSet = exceptions.toSet();

    void addOccurrence(DateTime occurrenceStart) {
      if (until != null && occurrenceStart.isAfter(until)) {
        return;
      }
      final occurrenceStartSeconds = occurrenceStart.secondsSinceEpoch;
      final occurrenceDateSeconds = occurrenceStart
          .onlyDate()
          .secondsSinceEpoch;
      if (exceptionSet.contains(occurrenceStartSeconds) ||
          exceptionSet.contains(occurrenceDateSeconds)) {
        return;
      }
      final occurrenceEnd = duration == Duration.zero
          ? source.end == null
                ? null
                : occurrenceStart
          : occurrenceStart.add(duration);
      if (_overlapsRange(
        occurrenceStart,
        occurrenceEnd,
        searchStart,
        windowEnd,
      )) {
        occurrences.add(_copyWithDates(source, occurrenceStart, occurrenceEnd));
      }
    }

    switch (repeatType) {
      case RepeatType.daily:
        _expandDaily(
          addOccurrence,
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.weekly:
        _expandWeekly(
          addOccurrence,
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          weekdays: weeklyWeekdays,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.monthly:
        _expandMonthly(
          addOccurrence,
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          monthDays: monthlyMonthDays,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.yearly:
        _expandYearly(
          addOccurrence,
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
    }

    return occurrences;
  }

  void _expandDaily(
    void Function(DateTime) addOccurrence, {
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) {
    if (count > 0) {
      for (var i = 0; i < count; i++) {
        final occurrenceStart = baseStart.add(Duration(days: i * interval));
        if (until != null && occurrenceStart.isAfter(until)) break;
        if (occurrenceStart.isAfter(windowEnd)) break;
        addOccurrence(occurrenceStart);
      }
      return;
    }

    var occurrenceStart = baseStart;
    if (searchStart.isAfter(baseStart)) {
      final diffDays = searchStart.difference(baseStart).inDays;
      final jump = diffDays ~/ interval;
      occurrenceStart = baseStart.add(Duration(days: jump * interval));
      while (occurrenceStart.isBefore(searchStart)) {
        occurrenceStart = occurrenceStart.add(Duration(days: interval));
      }
    }

    while (!occurrenceStart.isAfter(windowEnd)) {
      if (until != null && occurrenceStart.isAfter(until)) break;
      addOccurrence(occurrenceStart);
      occurrenceStart = occurrenceStart.add(Duration(days: interval));
    }
  }

  void _expandWeekly(
    void Function(DateTime) addOccurrence, {
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> weekdays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) {
    final normalizedWeekdays =
        (weekdays.isEmpty ? [baseStart.weekday] : weekdays)
            .where(
              (weekday) =>
                  weekday >= DateTime.monday && weekday <= DateTime.sunday,
            )
            .toSet()
            .toList()
          ..sort();
    final baseWeekStart = baseStart.onlyDate().subtract(
      Duration(days: baseStart.weekday - 1),
    );

    if (count > 0) {
      var produced = 0;
      var weekOffset = 0;
      while (produced < count) {
        final weekStart = baseWeekStart.add(Duration(days: weekOffset * 7));
        for (final weekday in normalizedWeekdays) {
          final day = weekStart.add(Duration(days: weekday - 1));
          final occurrenceStart = DateTime(
            day.year,
            day.month,
            day.day,
            baseStart.hour,
            baseStart.minute,
            baseStart.second,
            baseStart.millisecond,
            baseStart.microsecond,
          );
          if (occurrenceStart.isBefore(baseStart)) continue;
          if (until != null && occurrenceStart.isAfter(until)) return;
          if (occurrenceStart.isAfter(windowEnd)) return;
          produced++;
          addOccurrence(occurrenceStart);
          if (produced >= count) return;
        }
        weekOffset += interval;
      }
      return;
    }

    var cursor = searchStart.onlyDate();
    final endDate = windowEnd.onlyDate();
    while (!cursor.isAfter(endDate)) {
      final occurrenceStart = DateTime(
        cursor.year,
        cursor.month,
        cursor.day,
        baseStart.hour,
        baseStart.minute,
        baseStart.second,
        baseStart.millisecond,
        baseStart.microsecond,
      );
      if (!occurrenceStart.isBefore(baseStart) &&
          normalizedWeekdays.contains(cursor.weekday)) {
        final cursorWeekStart = cursor.subtract(
          Duration(days: cursor.weekday - 1),
        );
        final weekDiff = cursorWeekStart.difference(baseWeekStart).inDays ~/ 7;
        if (weekDiff >= 0 && weekDiff % interval == 0) {
          if (until != null && occurrenceStart.isAfter(until)) return;
          addOccurrence(occurrenceStart);
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
  }

  void _expandMonthly(
    void Function(DateTime) addOccurrence, {
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> monthDays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) {
    final normalizedMonthDays =
        (monthDays.isEmpty ? [baseStart.day] : monthDays)
            .where((day) => day >= 1 && day <= 31)
            .toSet()
            .toList()
          ..sort();
    final baseMonth = DateTime(baseStart.year, baseStart.month);

    DateTime createOccurrenceStart(DateTime month, int day) => DateTime(
      month.year,
      month.month,
      day,
      baseStart.hour,
      baseStart.minute,
      baseStart.second,
      baseStart.millisecond,
      baseStart.microsecond,
    );

    void emitMonth(DateTime month) {
      final maxDay = _daysInMonth(month.year, month.month);
      for (final day in normalizedMonthDays) {
        if (day > maxDay) continue;
        final occurrenceStart = createOccurrenceStart(month, day);
        if (occurrenceStart.isBefore(baseStart)) continue;
        addOccurrence(occurrenceStart);
      }
    }

    if (count > 0) {
      var produced = 0;
      var monthOffset = 0;
      while (produced < count) {
        final month = DateTime(baseMonth.year, baseMonth.month + monthOffset);
        final maxDay = _daysInMonth(month.year, month.month);
        for (final day in normalizedMonthDays) {
          if (day > maxDay) continue;
          final occurrenceStart = createOccurrenceStart(month, day);
          if (occurrenceStart.isBefore(baseStart)) continue;
          if (until != null && occurrenceStart.isAfter(until)) return;
          if (occurrenceStart.isAfter(windowEnd)) return;
          produced++;
          addOccurrence(occurrenceStart);
          if (produced >= count) return;
        }
        monthOffset += interval;
      }
      return;
    }

    final startMonth = DateTime(searchStart.year, searchStart.month);
    var monthDiff =
        (startMonth.year - baseMonth.year) * 12 +
        (startMonth.month - baseMonth.month);
    if (monthDiff < 0) {
      monthDiff = 0;
    }
    monthDiff -= monthDiff % interval;

    var currentMonth = DateTime(baseMonth.year, baseMonth.month + monthDiff);
    while (!currentMonth.isAfter(DateTime(windowEnd.year, windowEnd.month))) {
      if (until != null &&
          DateTime(currentMonth.year, currentMonth.month, 1).isAfter(until)) {
        break;
      }
      emitMonth(currentMonth);
      currentMonth = DateTime(currentMonth.year, currentMonth.month + interval);
    }
  }

  void _expandYearly(
    void Function(DateTime) addOccurrence, {
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) {
    if (count > 0) {
      for (var i = 0; i < count; i++) {
        final year = baseStart.year + i * interval;
        if (!_isValidDayInMonth(year, baseStart.month, baseStart.day)) {
          continue;
        }
        final occurrenceStart = DateTime(
          year,
          baseStart.month,
          baseStart.day,
          baseStart.hour,
          baseStart.minute,
          baseStart.second,
          baseStart.millisecond,
          baseStart.microsecond,
        );
        if (until != null && occurrenceStart.isAfter(until)) break;
        if (occurrenceStart.isAfter(windowEnd)) break;
        addOccurrence(occurrenceStart);
      }
      return;
    }

    var year = baseStart.year;
    if (searchStart.year > baseStart.year) {
      var diff = searchStart.year - baseStart.year;
      diff -= diff % interval;
      year = baseStart.year + diff;
    }
    while (true) {
      if (!_isValidDayInMonth(year, baseStart.month, baseStart.day)) {
        year += interval;
        continue;
      }
      final occurrenceStart = DateTime(
        year,
        baseStart.month,
        baseStart.day,
        baseStart.hour,
        baseStart.minute,
        baseStart.second,
        baseStart.millisecond,
        baseStart.microsecond,
      );
      if (occurrenceStart.isBefore(baseStart)) {
        year += interval;
        continue;
      }
      if (occurrenceStart.isAfter(windowEnd)) break;
      if (until != null && occurrenceStart.isAfter(until)) break;
      addOccurrence(occurrenceStart);
      year += interval;
    }
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  bool _isValidDayInMonth(int year, int month, int day) =>
      day <= _daysInMonth(year, month);

  CalendarItem _copyWithDates(
    CalendarItem item,
    DateTime? start,
    DateTime? end,
  ) {
    return switch (item) {
      FixedCalendarItem fixed => fixed.copyWith(start: start, end: end),
      RepeatingCalendarItem repeating => repeating.copyWith(
        start: start,
        end: end,
      ),
    };
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
  }) => service.getCalendarItems(
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
