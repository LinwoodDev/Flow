import 'package:flow_api/helpers/recurrence_engine.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:test/test.dart';

void main() {
  group('RecurrenceEngine.getNextOccurrenceDate', () {
    test('calculates next daily occurrence correctly', () {
      final baseStart = DateTime(2026, 7, 1, 9, 0);
      final item = RepeatingCalendarItem(
        start: baseStart,
        repeatType: RepeatType.daily,
        interval: 1,
      );

      final next = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: baseStart,
      );

      expect(next, equals(DateTime(2026, 7, 2, 9, 0)));
    });

    test('calculates next daily occurrence with interval 2', () {
      final baseStart = DateTime(2026, 7, 1, 10, 0);
      final item = RepeatingCalendarItem(
        start: baseStart,
        repeatType: RepeatType.daily,
        interval: 2,
      );

      final next = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: baseStart,
      );

      expect(next, equals(DateTime(2026, 7, 3, 10, 0)));
    });

    test('calculates next weekly occurrence for selected weekdays', () {
      // 2026-07-20 is a Monday (1)
      final baseStart = DateTime(2026, 7, 20, 14, 0);
      final variation = RepeatingCalendarItem.encodeWeeklyWeekdays([
        DateTime.monday,
        DateTime.friday,
      ]);
      final item = RepeatingCalendarItem(
        start: baseStart,
        repeatType: RepeatType.weekly,
        interval: 1,
        variation: variation,
      );

      // Next after Monday (2026-07-20) should be Friday (2026-07-24)
      final nextFriday = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: baseStart,
      );
      expect(nextFriday, equals(DateTime(2026, 7, 24, 14, 0)));

      // Next after Friday (2026-07-24) should be next Monday (2026-07-27)
      final nextMonday = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: nextFriday,
      );
      expect(nextMonday, equals(DateTime(2026, 7, 27, 14, 0)));
    });

    test('respects count limit', () {
      final baseStart = DateTime(2026, 7, 1, 9, 0);
      final item = RepeatingCalendarItem(
        start: baseStart,
        repeatType: RepeatType.daily,
        interval: 1,
        count: 2,
      );

      final secondOccurrence = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: baseStart,
      );
      expect(secondOccurrence, equals(DateTime(2026, 7, 2, 9, 0)));

      final thirdOccurrence = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: secondOccurrence,
      );
      expect(thirdOccurrence, isNull);
    });

    test('respects until date', () {
      final baseStart = DateTime(2026, 7, 1, 9, 0);
      final until = DateTime(2026, 7, 2, 23, 59);
      final item = RepeatingCalendarItem(
        start: baseStart,
        repeatType: RepeatType.daily,
        interval: 1,
        until: until,
      );

      final next = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: baseStart,
      );
      expect(next, equals(DateTime(2026, 7, 2, 9, 0)));

      final pastUntil = RecurrenceEngine.getNextOccurrenceDate(
        item,
        afterDate: next,
      );
      expect(pastUntil, isNull);
    });
  });
}
