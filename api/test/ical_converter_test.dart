import 'package:flow_api/converters/ical.dart';
import 'package:flow_api/models/cached.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:test/test.dart';

void main() {
  group('ICalConverter', () {
    test('parses folded, escaped, recurring events with exceptions', () {
      final converter = ICalConverter();

      converter.read([
        'BEGIN:VCALENDAR',
        'X-WR-CALNAME:Work\\, Personal',
        'BEGIN:VEVENT',
        'SUMMARY:Planning\\, weekly',
        r'DESCRIPTION:First line\nsecond line',
        ' continued',
        'LOCATION:Room\\; 2',
        'DTSTART:20260720T090000Z',
        'DTEND:20260720T100000Z',
        'RRULE:FREQ=WEEKLY;INTERVAL=2;COUNT=4;BYDAY=MO,WE',
        'EXDATE:20260722T090000Z,20260803T090000Z',
        'STATUS:TENTATIVE',
        'END:VEVENT',
        'END:VCALENDAR',
      ]);

      final data = converter.data!;
      expect(data.events.single.name, 'Work, Personal');
      final item = data.items.single as RepeatingCalendarItem;
      expect(item.name, 'Planning, weekly');
      expect(item.description, 'First line\nsecond linecontinued');
      expect(item.location, 'Room; 2');
      expect(item.start, DateTime.utc(2026, 7, 20, 9));
      expect(item.end, DateTime.utc(2026, 7, 20, 10));
      expect(item.status, EventStatus.draft);
      expect(item.repeatType, RepeatType.weekly);
      expect(item.interval, 2);
      expect(item.count, 4);
      expect(item.weeklyVariationWeekdays, [
        DateTime.monday,
        DateTime.wednesday,
      ]);
      expect(item.exceptions, [
        DateTime.utc(2026, 7, 22, 9).millisecondsSinceEpoch ~/ 1000,
        DateTime.utc(2026, 8, 3, 9).millisecondsSinceEpoch ~/ 1000,
      ]);
    });

    test('round trips event recurrence and escaped text', () {
      final item = RepeatingCalendarItem(
        name: 'Review, plan',
        description: 'First line\nSecond; line',
        location: r'Room \ A',
        start: DateTime.utc(2026, 7, 21, 13, 30),
        end: DateTime.utc(2026, 7, 21, 14, 15),
        status: EventStatus.cancelled,
        repeatType: RepeatType.monthly,
        interval: 3,
        count: 5,
        variation: RepeatingCalendarItem.encodeMonthlyMonthDays([1, 15, 31]),
        exceptions: [
          DateTime.utc(2026, 10, 21, 13, 30).millisecondsSinceEpoch ~/ 1000,
        ],
      );
      final writer = ICalConverter(CachedData(items: [item]));

      final reader = ICalConverter()..read(writer.write(Event(name: 'Team')));
      final decoded = reader.data!.items.single as RepeatingCalendarItem;

      expect(decoded.name, item.name);
      expect(decoded.description, item.description);
      expect(decoded.location, item.location);
      expect(decoded.start, item.start);
      expect(decoded.end, item.end);
      expect(decoded.status, item.status);
      expect(decoded.repeatType, item.repeatType);
      expect(decoded.interval, item.interval);
      expect(decoded.count, item.count);
      expect(decoded.monthlyVariationMonthDays, [1, 15, 31]);
      expect(decoded.exceptions, item.exceptions);
    });

    test('round trips tasks and preserves status and priority', () {
      const note = Note(
        name: 'Prepare release',
        description: 'Check docs, packages; and signing',
        status: NoteStatus.inProgress,
        priority: 3,
      );
      final writer = ICalConverter(CachedData(notes: [note]));

      final reader = ICalConverter()..read(writer.write());
      final decoded = reader.data!.notes.single;

      expect(decoded.name, note.name);
      expect(decoded.description, note.description);
      expect(decoded.status, note.status);
      expect(decoded.priority, note.priority);
    });

    test('ignores malformed values without losing valid components', () {
      final converter = ICalConverter()
        ..read([
          'BEGIN:VCALENDAR',
          'BROKEN',
          'BEGIN:VEVENT',
          'SUMMARY:Still imported',
          'DTSTART:not-a-date',
          'RRULE:FREQ=WEEKLY;INTERVAL=invalid;COUNT=invalid;BYDAY=XX,FR',
          'EXDATE:invalid,20260724T090000Z',
          'END:VEVENT',
          'END:VCALENDAR',
        ]);

      final item = converter.data!.items.single as RepeatingCalendarItem;
      expect(item.name, 'Still imported');
      expect(item.start, isNull);
      expect(item.interval, 1);
      expect(item.count, 0);
      expect(item.weeklyVariationWeekdays, [DateTime.friday]);
      expect(item.exceptions, hasLength(1));
    });
  });
}
