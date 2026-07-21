import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/widgets/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpDialogLauncher(
    WidgetTester tester,
    ValueChanged<bool> onResult,
  ) => tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () async {
              final result = await confirmDelete(
                context,
                title: 'Delete project',
                message: 'This cannot be undone.',
              );
              onResult(result);
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );

  testWidgets('cancel keeps the destructive action from running', (
    tester,
  ) async {
    bool? result;
    await pumpDialogLauncher(tester, (value) => result = value);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('This cannot be undone.'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, isFalse);
    expect(find.text('This cannot be undone.'), findsNothing);
  });

  testWidgets('delete confirms the destructive action', (tester) async {
    bool? result;
    await pumpDialogLauncher(tester, (value) => result = value);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(result, isTrue);
  });
}
