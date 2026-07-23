import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../../helpers/recurrence_engine.dart';
import '../../../services/database.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';
import 'service.dart';

class CalendarItemDatabaseService extends CalendarItemService
    with TableService {
  CalendarItemDatabaseService();

  static const _defaultRangeDays = 31;
  static const _repeatingRuntimeType = 'RepeatingCalendarItem';

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
    if (status?.isEmpty == true ||
        groupIds?.isEmpty == true ||
        resourceIds?.isEmpty == true ||
        limit <= 0) {
      return [];
    }

    final baseWhere = _buildBaseWhere(
      status: status,
      eventId: eventId,
      groupIds: groupIds,
      resourceIds: resourceIds,
      pending: pending,
      search: search,
    );
    final hasTemporalFilter = start != null || end != null || date != null;

    if (!hasTemporalFilter) {
      return _queryItems(
        where: baseWhere.where,
        whereArgs: baseWhere.args,
        offset: offset,
        limit: limit,
      );
    }

    final window = _CalendarItemWindow.fromFilters(
      start: start,
      end: end,
      date: date,
      defaultRangeDays: _defaultRangeDays,
    );

    final fixedWhere = baseWhere.copy();
    fixedWhere.add('runtimeType != ?', [_repeatingRuntimeType]);
    fixedWhere.add('(start IS NOT NULL OR end IS NOT NULL)');
    fixedWhere.add(
      '(((end IS NULL OR end > ?) AND (start IS NULL OR start < ?)) OR '
      '(start = end AND start >= ? AND start < ?))',
      [
        window.start.secondsSinceEpoch,
        window.end.secondsSinceEpoch,
        window.start.secondsSinceEpoch,
        window.end.secondsSinceEpoch,
      ],
    );

    final repeatingWhere = baseWhere.copy();
    repeatingWhere.add('runtimeType = ?', [_repeatingRuntimeType]);
    // Limit recurrence definitions to rows that can potentially produce
    // occurrences inside the requested window.
    repeatingWhere.add('start IS NOT NULL');
    repeatingWhere.add('start <= ?', [window.end.secondsSinceEpoch]);
    repeatingWhere.add('(until IS NULL OR until >= ?)', [
      window.start.secondsSinceEpoch,
    ]);

    final fixedItems = await _queryItems(
      where: fixedWhere.where,
      whereArgs: fixedWhere.args,
    );
    final repeatingDefinitions = await _queryItems(
      where: repeatingWhere.where,
      whereArgs: repeatingWhere.args,
    );

    return _mergeCalendarItems(
      fixedItems,
      repeatingDefinitions,
      window.start,
      window.end,
      start: start,
      end: end,
      date: date,
      offset: offset,
      limit: limit,
    );
  }

  _WhereClause _buildBaseWhere({
    required List<EventStatus>? status,
    required Uint8List? eventId,
    required List<Uint8List>? groupIds,
    required List<Uint8List>? resourceIds,
    required bool pending,
    required String search,
  }) {
    final where = _WhereClause();

    if (status != null) {
      where.add(
        'status IN (${_placeholders(status.length)})',
        status.map((e) => e.name),
      );
    }
    if (pending) {
      where.add('start IS NULL AND end IS NULL');
    }
    if (search.isNotEmpty) {
      where.add('(name LIKE ? OR description LIKE ?)', [
        '%$search%',
        '%$search%',
      ]);
    }
    if (eventId != null) {
      where.add('eventId = ?', [eventId]);
    }
    if (groupIds != null) {
      final placeholders = _placeholders(groupIds.length);
      where.add(
        '(calendarItems.id IN (SELECT itemId FROM calendarItemGroups WHERE groupId IN ($placeholders)) OR '
        'calendarItems.eventId IN (SELECT eventId FROM eventGroups WHERE groupId IN ($placeholders)))',
        [...groupIds, ...groupIds],
      );
    }
    if (resourceIds != null) {
      final placeholders = _placeholders(resourceIds.length);
      where.add(
        '(calendarItems.id IN (SELECT itemId FROM calendarItemResources WHERE resourceId IN ($placeholders)) OR '
        'calendarItems.eventId IN (SELECT eventId FROM eventResources WHERE resourceId IN ($placeholders)))',
        [...resourceIds, ...resourceIds],
      );
    }

    return where;
  }

  String _placeholders(int length) => List.filled(length, '?').join(', ');

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
      orderBy:
          'calendarItems.start ASC, calendarItems.end ASC, calendarItems.name ASC',
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

  List<ConnectedModel<CalendarItem, Event?>> _mergeCalendarItems(
    List<ConnectedModel<CalendarItem, Event?>> fixedItems,
    List<ConnectedModel<CalendarItem, Event?>> repeatingDefinitions,
    DateTime windowStart,
    DateTime windowEnd, {
    DateTime? start,
    DateTime? end,
    DateTime? date,
    required int offset,
    required int limit,
  }) {
    fixedItems.sort(_compareCalendarItems);
    final repeatingQueue = PriorityQueue<_CalendarItemCursor>(
      (a, b) => _compareCalendarItems(a.current, b.current),
    );

    for (final definition in repeatingDefinitions) {
      final iterator = _expandConnectedForRange(
        definition,
        windowStart,
        windowEnd,
        start: start,
        end: end,
        date: date,
      ).iterator;
      if (iterator.moveNext()) {
        repeatingQueue.add(_CalendarItemCursor(iterator.current, iterator));
      }
    }

    final page = <ConnectedModel<CalendarItem, Event?>>[];
    final skip = offset < 0 ? 0 : offset;
    final take = limit < 0 ? 0 : limit;
    var skipped = 0;
    var fixedIndex = 0;

    while (page.length < take &&
        (fixedIndex < fixedItems.length || repeatingQueue.isNotEmpty)) {
      final nextRepeating = repeatingQueue.isEmpty
          ? null
          : repeatingQueue.removeFirst();
      final nextFixed = fixedIndex < fixedItems.length
          ? fixedItems[fixedIndex]
          : null;

      late final ConnectedModel<CalendarItem, Event?> next;
      if (nextRepeating == null) {
        next = nextFixed!;
        fixedIndex++;
      } else if (nextFixed == null ||
          _compareCalendarItems(nextRepeating.current, nextFixed) <= 0) {
        next = nextRepeating.current;
        if (nextRepeating.iterator.moveNext()) {
          repeatingQueue.add(
            _CalendarItemCursor(
              nextRepeating.iterator.current,
              nextRepeating.iterator,
            ),
          );
        }
      } else {
        next = nextFixed;
        fixedIndex++;
        repeatingQueue.add(nextRepeating);
      }

      if (skipped < skip) {
        skipped++;
      } else {
        page.add(next);
      }
    }

    return page;
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
    if (start != null || end != null) {
      final window = _CalendarItemWindow.fromFilters(
        start: start,
        end: end,
        defaultRangeDays: _defaultRangeDays,
      );
      if (!_overlapsRange(item.start, item.end, window.start, window.end)) {
        return false;
      }
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
    if (itemStart != null && itemEnd != null && itemStart == itemEnd) {
      return !itemStart.isBefore(rangeStart) && itemStart.isBefore(rangeEnd);
    }
    return (itemEnd == null || itemEnd.isAfter(rangeStart)) &&
        (itemStart == null || itemStart.isBefore(rangeEnd));
  }

  DateTime _endOfDay(DateTime date) =>
      date.onlyDate().add(const Duration(hours: 23, minutes: 59, seconds: 59));

  Iterable<CalendarItem> _expandRepeatingCalendarItem(
    RepeatingCalendarItem item,
    DateTime windowStart,
    DateTime windowEnd,
  ) sync* {
    final baseStart = item.start;
    if (baseStart == null) {
      yield item;
      return;
    }
    final baseEnd = item.end;
    final duration = baseEnd?.difference(baseStart) ?? Duration.zero;
    final searchStart = duration > Duration.zero
        ? windowStart.subtract(duration)
        : windowStart;
    yield* _expandRecurring(
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

  Iterable<CalendarItem> _expandRecurring(
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
  }) sync* {
    final safeInterval = interval <= 0 ? 1 : interval;
    final exceptionSet = exceptions.toSet();

    CalendarItem? buildOccurrence(DateTime occurrenceStart) {
      if (until != null && occurrenceStart.isAfter(until)) {
        return null;
      }
      final occurrenceStartSeconds = occurrenceStart.secondsSinceEpoch;
      final occurrenceDateSeconds = occurrenceStart
          .onlyDate()
          .secondsSinceEpoch;
      if (exceptionSet.contains(occurrenceStartSeconds) ||
          exceptionSet.contains(occurrenceDateSeconds)) {
        return null;
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
        return _copyWithDates(source, occurrenceStart, occurrenceEnd);
      }
      return null;
    }

    Iterable<DateTime> occurrenceStarts;
    switch (repeatType) {
      case RepeatType.daily:
        occurrenceStarts = _expandDaily(
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.weekly:
        occurrenceStarts = _expandWeekly(
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
        occurrenceStarts = _expandMonthly(
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
        occurrenceStarts = _expandYearly(
          baseStart: baseStart,
          interval: safeInterval,
          count: count,
          until: until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
    }

    for (final occurrenceStart in occurrenceStarts) {
      final occurrence = buildOccurrence(occurrenceStart);
      if (occurrence != null) {
        yield occurrence;
      }
    }
  }

  Iterable<DateTime> _expandDaily({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
    if (count > 0) {
      for (var i = 0; i < count; i++) {
        final occurrenceStart = _addCalendarDays(baseStart, i * interval);
        if (until != null && occurrenceStart.isAfter(until)) break;
        if (occurrenceStart.isAfter(windowEnd)) break;
        yield occurrenceStart;
      }
      return;
    }

    var occurrenceStart = baseStart;
    if (searchStart.isAfter(baseStart)) {
      final diffDays = searchStart.difference(baseStart).inDays;
      final jump = diffDays ~/ interval;
      occurrenceStart = _addCalendarDays(baseStart, jump * interval);
      while (occurrenceStart.isBefore(searchStart)) {
        occurrenceStart = _addCalendarDays(occurrenceStart, interval);
      }
    }

    while (!occurrenceStart.isAfter(windowEnd)) {
      if (until != null && occurrenceStart.isAfter(until)) break;
      yield occurrenceStart;
      occurrenceStart = _addCalendarDays(occurrenceStart, interval);
    }
  }

  DateTime _addCalendarDays(DateTime date, int days) => DateTime(
    date.year,
    date.month,
    date.day + days,
    date.hour,
    date.minute,
    date.second,
    date.millisecond,
    date.microsecond,
  );

  Iterable<DateTime> _expandWeekly({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> weekdays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
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
          yield occurrenceStart;
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
          yield occurrenceStart;
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
  }

  Iterable<DateTime> _expandMonthly({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> monthDays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
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

    Iterable<DateTime> emitMonth(DateTime month) sync* {
      final maxDay = _daysInMonth(month.year, month.month);
      for (final day in normalizedMonthDays) {
        if (day > maxDay) continue;
        final occurrenceStart = createOccurrenceStart(month, day);
        if (occurrenceStart.isBefore(baseStart)) continue;
        yield occurrenceStart;
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
          yield occurrenceStart;
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
      yield* emitMonth(currentMonth);
      currentMonth = DateTime(currentMonth.year, currentMonth.month + interval);
    }
  }

  Iterable<DateTime> _expandYearly({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
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
        yield occurrenceStart;
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
      yield occurrenceStart;
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
    return result?.map(CalendarItem.fromDatabase).firstOrNull;
  }

  @override
  Future<void> clear() async {
    await db?.delete('calendarItems');
  }

  @override
  Future<CalendarItem?> completeOccurrence(CalendarItem item) async {
    if (item.id == null) return null;

    if (item is FixedCalendarItem) {
      final newStatus = item.status == EventStatus.completed
          ? EventStatus.confirmed
          : EventStatus.completed;
      final updated = item.copyWith(status: newStatus);
      final success = await updateCalendarItem(updated);
      return success ? updated : null;
    }

    if (item is RepeatingCalendarItem) {
      final occurrenceStart = item.start;
      if (occurrenceStart == null) return null;

      final completedInstance = FixedCalendarItem(
        id: createUniqueUint8List(),
        name: item.name,
        description: item.description,
        location: item.location,
        eventId: item.eventId,
        start: occurrenceStart,
        end: item.end,
        status: EventStatus.completed,
      );
      await createCalendarItem(completedInstance);

      final occurrenceStartSec = occurrenceStart.secondsSinceEpoch;
      final occurrenceDateSec = occurrenceStart.onlyDate().secondsSinceEpoch;
      final updatedExceptions = {
        ...item.exceptions,
        occurrenceStartSec,
        occurrenceDateSec,
      }.toList()..sort();

      final nextDate = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: occurrenceStart,
      );

      final duration = item.end != null && item.start != null
          ? item.end!.difference(item.start!)
          : Duration.zero;

      final updatedSeries = item.copyWith(
        exceptions: updatedExceptions,
        start: nextDate ?? item.start,
        end: nextDate != null
            ? (duration == Duration.zero ? nextDate : nextDate.add(duration))
            : item.end,
      );

      await updateCalendarItem(updatedSeries);
      return completedInstance;
    }

    return null;
  }

  @override
  Future<bool> deleteOccurrence(
    CalendarItem item, {
    bool deleteSeries = false,
  }) async {
    final id = item.id;
    if (id == null) return false;

    if (deleteSeries || item is FixedCalendarItem) {
      return await deleteCalendarItem(id);
    }

    if (item is RepeatingCalendarItem) {
      final occurrenceStart = item.start;
      if (occurrenceStart == null) return false;

      final occurrenceStartSec = occurrenceStart.secondsSinceEpoch;
      final occurrenceDateSec = occurrenceStart.onlyDate().secondsSinceEpoch;
      final updatedExceptions = {
        ...item.exceptions,
        occurrenceStartSec,
        occurrenceDateSec,
      }.toList()..sort();

      final nextDate = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: occurrenceStart,
      );

      final duration = item.end != null && item.start != null
          ? item.end!.difference(item.start!)
          : Duration.zero;

      final updatedSeries = item.copyWith(
        exceptions: updatedExceptions,
        start: nextDate ?? item.start,
        end: nextDate != null
            ? (duration == Duration.zero ? nextDate : nextDate.add(duration))
            : item.end,
      );

      return await updateCalendarItem(updatedSeries);
    }

    return false;
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
  FutureOr<CalendarItem?> completeOccurrence(CalendarItem item) =>
      service.completeOccurrence(item);

  @override
  FutureOr<bool> deleteOccurrence(CalendarItem item, {bool deleteSeries = false}) =>
      service.deleteOccurrence(item, deleteSeries: deleteSeries);

  @override
  FutureOr<void> clear() => service.clear();
}

class _CalendarItemCursor {
  final ConnectedModel<CalendarItem, Event?> current;
  final Iterator<ConnectedModel<CalendarItem, Event?>> iterator;

  _CalendarItemCursor(this.current, this.iterator);
}

class _CalendarItemWindow {
  final DateTime start;
  final DateTime end;

  const _CalendarItemWindow(this.start, this.end);

  factory _CalendarItemWindow.fromFilters({
    DateTime? start,
    DateTime? end,
    DateTime? date,
    required int defaultRangeDays,
  }) {
    final windowStart =
        date?.onlyDate() ??
        start ??
        end?.subtract(Duration(days: defaultRangeDays)) ??
        DateTime.now().subtract(Duration(days: defaultRangeDays));
    final windowEnd = date != null
        ? _endOfDay(date)
        : end ??
              start?.add(Duration(days: defaultRangeDays)) ??
              DateTime.now().add(Duration(days: defaultRangeDays));
    return _CalendarItemWindow(windowStart, windowEnd);
  }

  static DateTime _endOfDay(DateTime date) =>
      date.onlyDate().add(const Duration(hours: 23, minutes: 59, seconds: 59));
}

class _WhereClause {
  final List<String> clauses;
  final List<Object?> args;

  _WhereClause({List<String>? clauses, List<Object?>? args})
    : clauses = clauses ?? [],
      args = args ?? [];

  String? get where => clauses.isEmpty ? null : clauses.join(' AND ');

  void add(String clause, [Iterable<Object?> values = const []]) {
    clauses.add(clause);
    args.addAll(values);
  }

  _WhereClause copy() => _WhereClause(
    clauses: List<String>.of(clauses),
    args: List<Object?>.of(args),
  );
}
