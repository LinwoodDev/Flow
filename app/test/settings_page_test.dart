import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/settings/home.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow_api/helpers/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_leap/settings_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setupAPI();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'Flow',
      packageName: 'flow',
      version: '0.8.0',
      buildNumber: '17',
      buildSignature: '',
    );
  });

  for (final width in [400.0, 1200.0]) {
    testWidgets('search and edit settings at width $width', (tester) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final cubit = SettingsCubit(await SharedPreferences.getInstance());
      addTearDown(cubit.close);
      await tester.pumpWidget(
        BlocProvider.value(
          value: cubit,
          child: MaterialApp(
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
              LeapLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: SettingsPage(isDialog: true)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Theme');
      await tester.pumpAndSettle();
      await tester.tap(
        find
            .ancestor(of: find.text('Theme'), matching: find.byType(ListTile))
            .first,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(SettingsLeapGeneratedPage<FlowSettings>),
        findsOneWidget,
      );
      await tester.tap(find.text('Theme').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dark').last);
      await tester.pumpAndSettle();
      expect(cubit.state.themeMode, ThemeMode.dark);
      final restored = SettingsCubit(await SharedPreferences.getInstance());
      expect(restored.state.themeMode, ThemeMode.dark);
      await restored.close();
      expect(tester.takeException(), isNull);
    });
  }
}
