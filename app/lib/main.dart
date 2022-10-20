import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flow/pages/settings/page.dart';
import 'package:flow/pages/users/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pages/calendar/page.dart';
import 'pages/dashboard/page.dart';
import 'pages/sources/page.dart';
import 'pages/places/page.dart';

import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  runApp(FlowApp());
}

class FlowApp extends StatelessWidget {
  FlowApp({Key? key}) : super(key: key);
  static const FlexScheme _usedScheme = FlexScheme.mandyRed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Linwood Flow',
      // Use a predefined FlexThemeData.light() theme for the light theme.
      theme: FlexThemeData.light(
        scheme: _usedScheme,
        useMaterial3: true,
        // Use very subtly themed app bar elevation in light mode.
        appBarElevation: 0.5,
        fontFamily: 'Comfortaa',
      ),
      // Same definition for the dark theme, but using FlexThemeData.dark().
      darkTheme: FlexThemeData.dark(
        scheme: _usedScheme,
        useMaterial3: true,
        // Use a bit more themed elevated app bar in dark mode.
        appBarElevation: 2,
        fontFamily: 'Comfortaa',
      ),
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
    );
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
