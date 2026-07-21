import 'package:flow/cubits/alarm.dart';
import 'package:flow/pages/alarm/page.dart';
import 'package:flow/pages/sources/caldav.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget localizedApp(Widget home) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: home),
);

void main() {
  testWidgets('source dialog keeps invalid URLs from connecting', (
    tester,
  ) async {
    await tester.pumpWidget(localizedApp(const CalDavSourceDialog()));

    await tester.tap(find.text('Connect'));
    await tester.pump();

    expect(find.text('Enter a valid HTTP or HTTPS URL'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('active alarms cannot be saved in the past', (tester) async {
    await tester.pumpWidget(
      localizedApp(
        AlarmDialog(
          initialValue: Alarm(
            date: DateTime.now().subtract(const Duration(minutes: 1)),
            title: 'Past alarm',
          ),
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(
      find.text('An active alarm must be scheduled in the future.'),
      findsOneWidget,
    );
  });
}
