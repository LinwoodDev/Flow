import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow_api/helpers/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setupAPI();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('setting changes survive cubit recreation', () async {
    final preferences = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(preferences);

    await cubit.changeThemeMode(ThemeMode.dark);
    await cubit.changeLocale('de');
    await cubit.changeSyncMode(SyncMode.manual);
    await cubit.changeStartOfWeek(DateTime.monday);
    await cubit.changeCalendarView(CalendarView.week);
    await cubit.close();

    final restored = SettingsCubit(await SharedPreferences.getInstance());
    addTearDown(restored.close);
    expect(restored.state.themeMode, ThemeMode.dark);
    expect(restored.state.locale, 'de');
    expect(restored.state.syncMode, SyncMode.manual);
    expect(restored.state.startOfWeek, DateTime.monday);
    expect(restored.state.calendarView, CalendarView.week);
  });

  test('settings import preserves locally stored remote accounts', () async {
    final preferences = await SharedPreferences.getInstance();
    final cubit = SettingsCubit(preferences);
    addTearDown(cubit.close);
    const remote = CalDavStorage(
      url: 'https://calendar.example.test/user/',
      username: 'flow',
    );
    await cubit.addStorage(remote);

    final imported = const FlowSettings(
      locale: 'fr',
      themeMode: ThemeMode.light,
      calendarView: CalendarView.month,
    );
    await cubit.importSettings(imported.toJson());

    expect(cubit.state.locale, 'fr');
    expect(cubit.state.themeMode, ThemeMode.light);
    expect(cubit.state.calendarView, CalendarView.month);
    expect(cubit.state.remotes, [remote]);

    final restored = SettingsCubit(await SharedPreferences.getInstance());
    addTearDown(restored.close);
    expect(restored.state.remotes, [remote]);
  });
}
