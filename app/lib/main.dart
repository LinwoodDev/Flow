import 'package:dynamic_color/dynamic_color.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/api/storage/db/database.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/theme.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/foundation.dart';
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
  final settingsCubit = SettingsCubit(prefs);

  final database = DatabaseService(openDatabase);
  await database.setup();

  await setup(settingsCubit);
  runApp(
    BlocProvider.value(
      value: settingsCubit,
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

Page<void> Function(BuildContext, GoRouterState) _fadeTransitionBuilder(
    Widget Function(BuildContext, GoRouterState) child) {
  return (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: child(context, state),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        ),
      );
}

class FlowApp extends StatelessWidget {
  FlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _buildApp(null, null);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          _buildApp(lightDynamic, darkDynamic),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: isNightly ? 'Linwood Flow Nightly' : 'Linwood Flow',
              // Use a predefined FlexThemeData.light() theme for the light theme.
              theme: getThemeData(state.design, false, lightDynamic),
              // Same definition for the dark theme, but using FlexThemeData.dark().
              darkTheme: getThemeData(state.design, true, darkDynamic),
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
              pageBuilder: _fadeTransitionBuilder(
                  (context, state) => const DashboardPage()),
            ),
            GoRoute(
              path: '/calendar',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => CalendarPage(
                  filter: state.extra is CalendarFilter
                      ? state.extra as CalendarFilter
                      : const CalendarFilter(),
                ),
              ),
            ),
            GoRoute(
              path: '/groups',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => const GroupsPage(),
              ),
            ),
            GoRoute(
              path: '/todos',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => const TodosPage(),
              ),
            ),
            GoRoute(
              path: '/places',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => const PlacesPage(),
              ),
            ),
            GoRoute(
              path: '/users',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => const UsersPage(),
              ),
            ),
            GoRoute(
              path: '/sources',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => const SourcesPage(),
              ),
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: _fadeTransitionBuilder(
                (context, state) => SettingsPage(),
              ),
            ),
          ]),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
