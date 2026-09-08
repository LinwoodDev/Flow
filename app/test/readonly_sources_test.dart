import 'dart:async';

import 'package:flow/api/storage/remote/ical.dart';
import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/remote/service.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/calendar/item.dart';
import 'package:flow/pages/events/event.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/widgets/source_dropdown.dart';
import 'package:flow_api/helpers/setup.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/event/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_leap/material_leap.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> _open({
  String name = '',
  int? version,
  FutureOr<void> Function(Database, int, int)? onUpgrade,
  FutureOr<void> Function(Database, int)? onCreate,
}) => databaseFactoryFfi.openDatabase(
  inMemoryDatabasePath,
  options: OpenDatabaseOptions(
    version: version,
    onCreate: onCreate,
    onUpgrade: onUpgrade,
    singleInstance: false,
  ),
);

void main() {
  setupAPI();
  sqfliteFfiInit();
  late RemoteDatabaseService cache;
  late IcalRemoteService remote;
  late SettingsCubit settings;
  late SourcesService sources;
  late FlowCubit flow;
  const storage = ICalStorage(
    name: 'Holidays',
    url: 'https://example.com/feed',
    username: '',
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    settings = SettingsCubit(await SharedPreferences.getInstance());
    await settings.addStorage(storage);
    cache = RemoteDatabaseService(_open);
    await cache.setup('test');
    remote = IcalRemoteService(storage, cache, null);
    sources = SourcesService(settings)..local = cache;
    sources.remotes.add(remote);
    flow = FlowCubit(sources);
  });
  tearDown(() async {
    await cache.db.close();
    await flow.close();
    await settings.close();
    await sources.syncState.close();
  });

  test(
    'subscription services reject all mutations but retain cached reads',
    () async {
      final event = (await cache.event.createEvent(
        const Event(name: 'Holiday'),
      ))!;
      final item = (await cache.calendarItem.createCalendarItem(
        FixedCalendarItem(name: 'Day off', start: DateTime(2026, 12, 25)),
      ))!;
      expect(remote.event.isEditable, false);
      expect(remote.calendarItem.isEditable, false);
      for (final action in <Future<dynamic> Function()>[
        () async => remote.event.createEvent(event),
        () async => remote.event.updateEvent(event),
        () async => remote.event.deleteEvent(event.id!),
        () async => remote.event.clear(),
        () async => remote.calendarItem.createCalendarItem(item),
        () async => remote.calendarItem.updateCalendarItem(item),
        () async => remote.calendarItem.deleteCalendarItem(item.id!),
        () async => remote.calendarItem.clear(),
      ]) {
        await expectLater(action(), throwsUnsupportedError);
      }
      expect((await remote.event.getEvent(event.id!))!.name, 'Holiday');
      expect(
        (await remote.calendarItem.getCalendarItem(item.id!))!.name,
        'Day off',
      );
      flow.setSources([storage.identifier]);
      expect(flow.canWrite((source) => source.event), false);
    },
  );

  Widget app(Widget child) => BlocProvider.value(
    value: flow,
    child: MaterialApp(
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        LeapLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );

  testWidgets('read-only destinations cannot be selected for creation', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        SourceDropdown<EventService>(
          value: '',
          buildService: (source) => source.event,
          onChanged: (_) => fail('Read-only source selected'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final entries = tester
        .widget<DropdownMenu<String>>(find.byType(DropdownMenu<String>))
        .dropdownMenuEntries;
    expect(
      entries.singleWhere((entry) => entry.value == storage.identifier).enabled,
      false,
    );
    expect(
      entries.singleWhere((entry) => entry.value == storage.identifier).label,
      contains('Read-only'),
    );
  });

  testWidgets('subscription records open as details with no write controls', (
    tester,
  ) async {
    for (final editor in [
      EventDialog(
        source: storage.identifier,
        event: const Event(name: 'Holiday'),
      ),
      CalendarItemDialog(
        source: storage.identifier,
        item: RepeatingCalendarItem(
          name: 'Day off',
          description: 'Calendar description',
          location: 'Berlin',
          start: DateTime(2026, 12, 25, 9),
          end: DateTime(2026, 12, 25, 10),
          repeatType: RepeatType.weekly,
          interval: 2,
          count: 8,
        ),
      ),
    ]) {
      await tester.pumpWidget(app(editor));
      await tester.pumpAndSettle();
      if (editor is CalendarItemDialog) {
        expect(find.text('Read-only'), findsOneWidget);
        expect(find.text('Day off'), findsWidgets);
        expect(find.text('Calendar description'), findsOneWidget);
        expect(find.text('Berlin'), findsOneWidget);
        expect(
          tester
              .widget<DropdownMenu<EventStatus>>(
                find.byType(DropdownMenu<EventStatus>),
              )
              .enabled,
          false,
        );
        expect(
          tester
              .widget<TextField>(
                find
                    .descendant(
                      of: find.byType(TextFormField).first,
                      matching: find.byType(TextField),
                    )
                    .first,
              )
              .readOnly,
          true,
        );
        await tester.drag(find.byType(ListView).first, const Offset(0, -500));
        await tester.pumpAndSettle();
        expect(find.byType(DateTimeField), findsWidgets);
        expect(
          tester
              .widget<DropdownMenu<RepeatType>>(
                find.byType(DropdownMenu<RepeatType>),
              )
              .initialSelection,
          RepeatType.weekly,
        );
        expect(
          tester
              .widget<DropdownMenu<RepeatType>>(
                find.byType(DropdownMenu<RepeatType>),
              )
              .enabled,
          false,
        );
      } else {
        expect(find.byType(TextFormField), findsNothing);
      }
      expect(find.text('Save'), findsNothing);
      expect(find.text('Delete'), findsNothing);
      expect(find.text('Close'), findsOneWidget);
    }
  });
}
