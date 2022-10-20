import 'package:flow/pages/settings/page.dart';
import 'package:flow/pages/users/page.dart';
import 'package:flow/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubits/settings.dart';
import 'pages/calendar/page.dart';
import 'pages/dashboard/page.dart';
import 'pages/sources/page.dart';
import 'pages/places/page.dart';

import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();

  await setup();
  runApp(BlocProvider(create: (_) => SettingsCubit(prefs), child: FlowApp()));
}

class FlowApp extends StatelessWidget {
  FlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => MaterialApp.router(
              routerConfig: _router,
              title: 'Linwood Flow',
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
    routes: <GoRoute>[
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
        builder: (BuildContext context, GoRouterState state) => SettingsPage(),
      ),
    ],
  );
}
