import 'dart:async';

import 'package:flow/api/storage/sources.dart';
import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/cubits/settings.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/widgets/paging/error.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_api/services/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestSourceService extends SourceService {}

class _TestFlowCubit extends FlowCubit {
  final SourceService service = _TestSourceService();

  _TestFlowCubit(super.sourcesService);

  @override
  List<String> getCurrentSources() => const ['test'];

  @override
  SourceService getService(String source) => service;
}

Widget _localizedApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  testWidgets('error indicator is descriptive and retries', (tester) async {
    var retries = 0;
    await tester.pumpWidget(
      _localizedApp(ErrorIndicatorDisplay(onTryAgain: () => retries++)),
    );

    expect(find.text('An error occurred'), findsOneWidget);
    expect(
      find.text('An error occurred while loading the data.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });

  testWidgets('dated paging shows an empty state when no sources are active', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final settings = SettingsCubit(preferences);
    final flow = FlowCubit(SourcesService(settings))..setSources([]);
    final bloc = SourcedPagingBloc<String>.dated(
      cubit: flow,
      fetch: (source, service, offset, limit, date) async => const [],
    );
    addTearDown(bloc.close);
    addTearDown(settings.close);
    addTearDown(flow.close);

    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: _localizedApp(
          PagedListView<String>.dated(
            bloc: bloc,
            dateBuilder: (context, items, index) => Text('Date $index'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No items found'), findsOneWidget);
    expect(find.text('The list is currently empty.'), findsOneWidget);
  });

  test('paging ignores overlapping fetch requests', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final settings = SettingsCubit(preferences);
    final flow = _TestFlowCubit(SourcesService(settings));
    final fetchResult = Completer<List<String>>();
    var fetchCount = 0;
    final bloc = SourcedPagingBloc<String>.item(
      cubit: flow,
      fetch: (source, service, offset, limit) {
        fetchCount++;
        return fetchResult.future;
      },
    );
    addTearDown(bloc.close);
    addTearDown(settings.close);
    addTearDown(flow.close);

    while (fetchCount == 0) {
      await Future<void>.delayed(Duration.zero);
    }
    bloc
      ..fetch()
      ..fetch();
    await Future<void>.delayed(Duration.zero);

    expect(fetchCount, 1);
    fetchResult.complete(const []);
    await bloc.stream.firstWhere((state) => state is SourcedPagingSuccess);
    expect(fetchCount, 1);
  });
}
