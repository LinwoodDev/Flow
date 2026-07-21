import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flow_api/helpers/setup.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/services/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setupAPI();
  sqfliteFfiInit();

  test('version 4 recurrence aliases migrate without data loss', () async {
    final tempDirectory = await Directory.systemTemp.createTemp(
      'flow-migration-test-',
    );
    final databasePath = '${tempDirectory.path}/flow.db';
    final id = Uint8List.fromList(List<int>.generate(16, (index) => index));

    try {
      final oldDatabase = await databaseFactoryFfi.openDatabase(
        databasePath,
        options: OpenDatabaseOptions(
          version: 4,
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE events (
                id BLOB(16) PRIMARY KEY,
                parentId BLOB(16),
                blocked INTEGER NOT NULL DEFAULT 1,
                name VARCHAR(100) NOT NULL DEFAULT '',
                description TEXT NOT NULL DEFAULT '',
                location TEXT NOT NULL DEFAULT '',
                extra TEXT
              )
            ''');
            await db.execute('''
              CREATE TABLE calendarItems (
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
                exceptions TEXT
              )
            ''');
          },
        ),
      );
      await oldDatabase.insert('calendarItems', {
        'runtimeType': 'auto',
        'id': id,
        'name': 'Legacy recurrence',
        'start': DateTime(2026, 7, 20, 9).millisecondsSinceEpoch ~/ 1000,
        'end': DateTime(2026, 7, 20, 10).millisecondsSinceEpoch ~/ 1000,
        'repeatType': 'weekly',
        'interval': 2,
        'variation': RepeatingCalendarItem.encodeWeeklyWeekdays([
          DateTime.monday,
        ]),
        'count': 3,
      });
      await oldDatabase.close();

      Future<Database> openMigratedDatabase({
        String name = '',
        int? version,
        FutureOr<void> Function(Database, int, int)? onUpgrade,
        FutureOr<void> Function(Database, int)? onCreate,
      }) => databaseFactoryFfi.openDatabase(
        databasePath,
        options: OpenDatabaseOptions(
          version: version,
          onUpgrade: onUpgrade,
          onCreate: onCreate,
          singleInstance: false,
        ),
      );

      final service = DatabaseService(openMigratedDatabase);
      await service.setup('flow');
      addTearDown(service.db.close);

      expect(await service.getVersion(), databaseVersion);
      final migrated = await service.calendarItem.getCalendarItem(id);
      expect(migrated, isA<RepeatingCalendarItem>());
      final recurrence = migrated! as RepeatingCalendarItem;
      expect(recurrence.name, 'Legacy recurrence');
      expect(recurrence.repeatType, RepeatType.weekly);
      expect(recurrence.interval, 2);
      expect(recurrence.count, 3);
      expect(recurrence.weeklyWeekdays, [DateTime.monday]);
    } finally {
      await tempDirectory.delete(recursive: true);
    }
  });
}
