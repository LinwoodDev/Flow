import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/pages/sources/caldav.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Sources extends SourcesService {
  RemoteStorage? added;
  String? password;
  _Sources(super.settingsCubit);
  @override
  Future<void> addRemote(RemoteStorage storage, String password) async {
    added = storage;
    this.password = password;
  }
}

void main() {
  testWidgets(
    'adding a named source extracts and saves credentials separately',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final settings = SettingsCubit(await SharedPreferences.getInstance());
      final sources = _Sources(settings);
      addTearDown(settings.close);
      addTearDown(sources.syncState.close);
      await tester.pumpWidget(
        RepositoryProvider<SourcesService>.value(
          value: sources,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const Scaffold(body: CalDavSourceDialog()),
          ),
        ),
      );
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), '  Work  ');
      await tester.enterText(
        fields.at(1),
        'https://alex%40work:p%3Aa%40ss@example.com/calendar?token=abc#fragment',
      );
      await tester.pump();
      String value(int index) =>
          tester.widget<TextFormField>(fields.at(index)).controller!.text;
      expect(value(1), 'https://example.com/calendar?token=abc#fragment');
      expect(value(2), 'alex@work');
      expect(value(3), 'p:a@ss');
      // Users can override credentials detected from the URL.
      await tester.enterText(fields.at(3), 'corrected');
      await tester.tap(find.text('Connect'));
      await tester.pumpAndSettle();
      expect(sources.added!.name, 'Work');
      expect(
        sources.added!.url,
        'https://example.com/calendar?token=abc#fragment',
      );
      expect(sources.added!.username, 'alex@work');
      expect(sources.password, 'corrected');
      expect(sources.added!.toJson(), isNot(contains('corrected')));
    },
  );
}
