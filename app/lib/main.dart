import 'package:flow/cubits/flow.dart';
import 'package:flow/api/storage/db/database.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/theme.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubits/settings.dart';
import 'pages/calendar/page.dart';
import 'pages/dashboard/page.dart';
import 'pages/groups/group/page.dart';
import 'pages/sources/page.dart';
import 'pages/places/page.dart';
import 'pages/groups/page.dart';
import 'pages/settings/page.dart';
import 'pages/users/page.dart';

import 'pages/todos/page.dart';
import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();

  final database = DatabaseService(openDatabase);
  await database.setup();

  await setup();
  runApp(
    BlocProvider(
      create: (_) => SettingsCubit(prefs),
      child: RepositoryProvider(
        create: (context) =>
            SourcesService(context.read<SettingsCubit>(), database),
        child: BlocProvider(
            create: (context) => FlowCubit(context.read<SourcesService>()),
            child: FlowApp()),
      ),
    ),
  );
}

class FlowApp extends StatelessWidget {
  FlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: isNightly ? 'Linwood Flow Nightly' : 'Linwood Flow',
              // Use a predefined FlexThemeData.light() theme for the light theme.
              theme: getThemeData(state.design, false),
              // Same definition for the dark theme, but using FlexThemeData.dark().
              darkTheme: getThemeData(state.design, true),
              themeMode: state.themeMode,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
                // Locale('de', ''), // German, no country code
              ],
            ));
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      ShellRoute(
          builder: (context, state, child) => FlowRootNavigation(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) =>
                  const DashboardPage(),
            ),
            GoRoute(
              path: '/calendar',
              builder: (BuildContext context, GoRouterState state) =>
                  const CalendarPage(),
            ),
            GoRoute(
              path: '/groups',
              builder: (BuildContext context, GoRouterState state) =>
                  const EventGroupsPage(),
              routes: <RouteBase>[
                GoRoute(
                  path: ':id',
                  builder: (BuildContext context, GoRouterState state) =>
                      EventGroupPage(
                    source: '',
                    eventGroupId: int.parse(state.params['id']!),
                  ),
                ), /*
          GoRoute(
            path: ':source/:id',
            builder: (BuildContext context, GoRouterState state) =>
                EventGroupPage(
              eventGroupId: int.parse(state.params['id']!),
              source: state.params['source']!,
            ),
          ),*/
              ],
            ),
            GoRoute(
              path: '/todos',
              builder: (BuildContext context, GoRouterState state) =>
                  const TodosPage(),
            ),
            GoRoute(
              path: '/places',
              builder: (BuildContext context, GoRouterState state) =>
                  const PlacesPage(),
            ),
            GoRoute(
              path: '/users',
              builder: (BuildContext context, GoRouterState state) =>
                  const UsersPage(),
            ),
            GoRoute(
              path: '/sources',
              builder: (BuildContext context, GoRouterState state) =>
                  const SourcesPage(),
            ),
            GoRoute(
              path: '/settings',
              builder: (BuildContext context, GoRouterState state) =>
                  SettingsPage(),
            ),
          ]),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
