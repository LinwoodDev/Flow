import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/sources/details.dart';
import 'package:flow/pages/sources/page.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow_api/helpers/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Sources extends SourcesService {
  int removed = 0;
  int count = 3;
  _Sources(super.settingsCubit);

  @override
  Future<Map<String, int>> getItemCounts(String source) async => {
    'events': count,
  };

  @override
  Future<void> removeRemote(String name) async {
    removed++;
    await settingsCubit.removeStorage(name);
  }
}

void main() {
  setupAPI();
  const remote = ICalStorage(
    url: 'https://example.com/calendar.ics',
    username: 'alex',
  );

  testWidgets('source details, count refresh, and confirmed deletion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({'nativeTitleBar': true});
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    await settings.addStorage(remote);
    final sources = _Sources(settings);
    addTearDown(settings.close);
    addTearDown(sources.syncState.close);
    await tester.pumpWidget(
      RepositoryProvider<SourcesService>.value(
        value: sources,
        child: BlocProvider.value(
          value: settings,
          child: MaterialApp(
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SourcesPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('3 stored items'), findsNWidgets(2));
    await tester.ensureVisible(find.text(remote.displayName));
    await tester.tap(find.text(remote.displayName));
    await tester.pumpAndSettle();
    expect(find.byType(SourceDetailsDialog), findsOneWidget);
    expect(find.text(remote.url), findsOneWidget);
    expect(find.text('Events: 3'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    sources.count = 4;
    sources.syncState.add(const SyncState());
    await tester.pumpAndSettle();
    expect(find.text('4 stored items'), findsNWidgets(2));
    final delete = find.byTooltip('Remove source ${remote.displayName}');
    await tester.ensureVisible(delete);
    await tester.tap(delete);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(sources.removed, 1);
    expect(find.text('No connected sources yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
