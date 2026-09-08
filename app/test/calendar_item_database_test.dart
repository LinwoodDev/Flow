import 'dart:async';

import 'package:flow_api/helpers/setup.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/services/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> _openTestDatabase({
  String name = '',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) => databaseFactoryFfi.openDatabase(
  inMemoryDatabasePath,
  options: OpenDatabaseOptions(
    version: version,
    onUpgrade: onUpgrade,
    onCreate: onCreate,
    singleInstance: false,
  ),
);

void main() {
  setupAPI();
  sqfliteFfiInit();

  late DatabaseService database;

  setUp(() async {
    database = DatabaseService(_openTestDatabase);
    await database.setup('test');
  });

  tearDown(() => database.db.close());

  test(
    'item counts include stored records without expanding recurrence',
    () async {
      expect((await database.getItemCounts()).values, everyElement(0));
      await database.event.createEvent(const Event(name: 'Work'));
      await database.calendarItem.createCalendarItem(
        RepeatingCalendarItem(
          name: 'Daily focus',
          start: DateTime(2026, 7, 20, 9),
          repeatType: RepeatType.daily,
          count: 100,
        ),
      );
      final counts = await database.getItemCounts();
      expect(counts['events'], 1);
      expect(counts['calendarItems'], 1);
      expect(counts.values.fold(0, (sum, count) => sum + count), 2);
      await database.calendarItem.clear();
      expect((await database.getItemCounts())['calendarItems'], 0);
    },
  );

  test('expands daily recurrence with count and exceptions', () async {
    final start = DateTime(2026, 7, 20, 9);
    await database.calendarItem.createCalendarItem(
      RepeatingCalendarItem(
        name: 'Daily focus',
        start: start,
        end: start.add(const Duration(hours: 1)),
        repeatType: RepeatType.daily,
        count: 4,
        exceptions: [DateTime(2026, 7, 21, 9).millisecondsSinceEpoch ~/ 1000],
      ),
    );

    final results = await database.calendarItem.getCalendarItems(
      start: DateTime(2026, 7, 20),
      end: DateTime(2026, 7, 25),
    );

    expect(results.map((entry) => entry.source.start), [
      DateTime(2026, 7, 20, 9),
      DateTime(2026, 7, 22, 9),
      DateTime(2026, 7, 23, 9),
    ]);
    expect(results.map((entry) => entry.source.end), [
      DateTime(2026, 7, 20, 10),
      DateTime(2026, 7, 22, 10),
      DateTime(2026, 7, 23, 10),
    ]);
  });

  test('expands selected weekdays and honors occurrence count', () async {
    final start = DateTime(2026, 7, 20, 9); // Monday.
    await database.calendarItem.createCalendarItem(
      RepeatingCalendarItem(
        name: 'Training',
        start: start,
        end: start.add(const Duration(minutes: 30)),
        repeatType: RepeatType.weekly,
        variation: RepeatingCalendarItem.encodeWeeklyWeekdays([
          DateTime.monday,
          DateTime.wednesday,
        ]),
        count: 5,
      ),
    );

    final results = await database.calendarItem.getCalendarItems(
      start: DateTime(2026, 7, 1),
      end: DateTime(2026, 8, 31),
    );

    expect(results.map((entry) => entry.source.start), [
      DateTime(2026, 7, 20, 9),
      DateTime(2026, 7, 22, 9),
      DateTime(2026, 7, 27, 9),
      DateTime(2026, 7, 29, 9),
      DateTime(2026, 8, 3, 9),
    ]);
  });

  test('merges fixed and recurring items before applying pagination', () async {
    await database.calendarItem.createCalendarItem(
      FixedCalendarItem(
        name: 'Fixed',
        start: DateTime(2026, 7, 21, 8),
        end: DateTime(2026, 7, 21, 9),
      ),
    );
    await database.calendarItem.createCalendarItem(
      RepeatingCalendarItem(
        name: 'Recurring',
        start: DateTime(2026, 7, 20, 8),
        end: DateTime(2026, 7, 20, 9),
        repeatType: RepeatType.daily,
        count: 3,
      ),
    );

    final results = await database.calendarItem.getCalendarItems(
      start: DateTime(2026, 7, 20),
      end: DateTime(2026, 7, 24),
      offset: 1,
      limit: 2,
    );

    expect(results.map((entry) => (entry.source.name, entry.source.start)), [
      ('Fixed', DateTime(2026, 7, 21, 8)),
      ('Recurring', DateTime(2026, 7, 21, 8)),
    ]);
  });

  test('keeps pending items out of dated windows', () async {
    await database.calendarItem.createCalendarItem(
      const FixedCalendarItem(name: 'Backlog'),
    );

    final dated = await database.calendarItem.getCalendarItems(
      start: DateTime(2026, 7, 20),
      end: DateTime(2026, 7, 21),
    );
    final pending = await database.calendarItem.getCalendarItems(pending: true);

    expect(dated, isEmpty);
    expect(pending.map((entry) => entry.source.name), ['Backlog']);
  });
}
