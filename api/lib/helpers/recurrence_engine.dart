import 'package:dart_leap/dart_leap.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';

class RecurrenceEngine {
  /// Calculates the next valid occurrence start date for a [RepeatingCalendarItem]
  /// strictly after [afterDate] (or after the item's start date).
  ///
  /// Returns `null` if the item reached its `count` limit or passed its `until` date.
  static DateTime? getNextOccurrenceDate(
    RepeatingCalendarItem item, {
    DateTime? afterDate,
  }) {
    final baseStart = item.start;
    if (baseStart == null) return null;

    final referenceDate = afterDate ?? baseStart;
    final searchStart = referenceDate.add(const Duration(milliseconds: 1));
    final windowEnd = searchStart.add(const Duration(days: 365 * 10));

    final exceptionSet = item.exceptions.toSet();
    final safeInterval = item.interval <= 0 ? 1 : item.interval;

    Iterable<DateTime> occurrenceStarts;
    switch (item.repeatType) {
      case RepeatType.daily:
        occurrenceStarts = _expandDaily(
          baseStart: baseStart,
          interval: safeInterval,
          count: item.count,
          until: item.until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.weekly:
        occurrenceStarts = _expandWeekly(
          baseStart: baseStart,
          interval: safeInterval,
          count: item.count,
          until: item.until,
          weekdays: item.weeklyWeekdays,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.monthly:
        occurrenceStarts = _expandMonthly(
          baseStart: baseStart,
          interval: safeInterval,
          count: item.count,
          until: item.until,
          monthDays: item.monthlyMonthDays,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
      case RepeatType.yearly:
        occurrenceStarts = _expandYearly(
          baseStart: baseStart,
          interval: safeInterval,
          count: item.count,
          until: item.until,
          searchStart: searchStart,
          windowEnd: windowEnd,
        );
        break;
    }

    for (final occurrenceStart in occurrenceStarts) {
      if (occurrenceStart.isBefore(searchStart)) continue;
      final occurrenceStartSeconds = occurrenceStart.secondsSinceEpoch;
      final occurrenceDateSeconds = occurrenceStart.onlyDate().secondsSinceEpoch;
      if (exceptionSet.contains(occurrenceStartSeconds) ||
          exceptionSet.contains(occurrenceDateSeconds)) {
        continue;
      }
      return occurrenceStart;
    }

    return null;
  }

  static Iterable<DateTime> _expandDaily({
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

  static DateTime _addCalendarDays(DateTime date, int days) => DateTime(
        date.year,
        date.month,
        date.day + days,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond,
      );

  static Iterable<DateTime> _expandWeekly({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required List<int> weekdays,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
    final normalizedWeekdays = (weekdays.isEmpty ? [baseStart.weekday] : weekdays)
        .where((weekday) => weekday >= DateTime.monday && weekday <= DateTime.sunday)
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
          normalizedWeekdays.contains(occurrenceStart.weekday)) {
        final weekDiff =
            occurrenceStart.onlyDate().difference(baseWeekStart).inDays ~/ 7;
        if (weekDiff >= 0 && weekDiff % interval == 0) {
          if (until != null && occurrenceStart.isAfter(until)) break;
          yield occurrenceStart;
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }
  }

  static Iterable<DateTime> _expandMonthly({
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

    if (count > 0) {
      var produced = 0;
      var monthOffset = 0;
      while (produced < count) {
        final targetMonth = DateTime(baseStart.year, baseStart.month + monthOffset, 1);
        final daysInMonth = DateTime(targetMonth.year, targetMonth.month + 1, 0).day;
        for (final day in normalizedMonthDays) {
          if (day > daysInMonth) continue;
          final occurrenceStart = DateTime(
            targetMonth.year,
            targetMonth.month,
            day,
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
        monthOffset += interval;
      }
      return;
    }

    var cursorMonth = DateTime(searchStart.year, searchStart.month, 1);
    final endMonth = DateTime(windowEnd.year, windowEnd.month, 1);
    final baseMonth = DateTime(baseStart.year, baseStart.month, 1);

    while (!cursorMonth.isAfter(endMonth)) {
      final monthDiff = (cursorMonth.year - baseMonth.year) * 12 +
          (cursorMonth.month - baseMonth.month);
      if (monthDiff >= 0 && monthDiff % interval == 0) {
        final daysInMonth = DateTime(cursorMonth.year, cursorMonth.month + 1, 0).day;
        for (final day in normalizedMonthDays) {
          if (day > daysInMonth) continue;
          final occurrenceStart = DateTime(
            cursorMonth.year,
            cursorMonth.month,
            day,
            baseStart.hour,
            baseStart.minute,
            baseStart.second,
            baseStart.millisecond,
            baseStart.microsecond,
          );
          if (occurrenceStart.isBefore(baseStart)) continue;
          if (until != null && occurrenceStart.isAfter(until)) break;
          if (occurrenceStart.isAfter(windowEnd)) break;
          yield occurrenceStart;
        }
      }
      cursorMonth = DateTime(cursorMonth.year, cursorMonth.month + 1, 1);
    }
  }

  static Iterable<DateTime> _expandYearly({
    required DateTime baseStart,
    required int interval,
    required int count,
    required DateTime? until,
    required DateTime searchStart,
    required DateTime windowEnd,
  }) sync* {
    if (count > 0) {
      for (var i = 0; i < count; i++) {
        final occurrenceStart = DateTime(
          baseStart.year + i * interval,
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

    var yearOffset = 0;
    if (searchStart.year > baseStart.year) {
      yearOffset = ((searchStart.year - baseStart.year) ~/ interval) * interval;
    }

    while (true) {
      final occurrenceStart = DateTime(
        baseStart.year + yearOffset,
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
      if (!occurrenceStart.isBefore(baseStart)) {
        yield occurrenceStart;
      }
      yearOffset += interval;
    }
  }
}
