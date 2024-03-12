import 'package:args/args.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/theme.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:lib5/lib5.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:flow_api/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:window_manager/window_manager.dart';

import 'cubits/settings.dart';
import 'pages/events/page.dart';
import 'pages/calendar/page.dart';
import 'pages/dashboard/page.dart';
import 'pages/sources/page.dart';
import 'pages/places/page.dart';
import 'pages/groups/page.dart';
import 'pages/settings/page.dart';
import 'pages/users/filter.dart';
import 'pages/users/page.dart';

import 'pages/notes/page.dart';
import 'setup.dart'
    if (dart.library.html) 'setup_web.dart'
    if (dart.library.io) 'setup_io.dart';

String? dataPath;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
  dataPath = result['path'];

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);

  final sourcesService = SourcesService(settingsCubit);
  await sourcesService.setup();

  await setup(settingsCubit, sourcesService);
  runApp(
    BlocProvider.value(
      value: settingsCubit,
      child: RepositoryProvider.value(
        value: sourcesService,
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
  FlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return _buildApp(null, null);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) =>
          _buildApp(lightDynamic, darkDynamic),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    return BlocBuilder<SettingsCubit, FlowSettings>(
        buildWhen: (previous, current) =>
            previous.design != current.design ||
            previous.themeMode != current.themeMode ||
            previous.locale != current.locale ||
            previous.density != current.density ||
            previous.highContrast != current.highContrast,
        builder: (context, state) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: applicationName,
              theme: getThemeData(state.design, false,
                  state.density.toFlutter(), lightDynamic, state.highContrast),
              darkTheme: getThemeData(state.design, true,
                  state.density.toFlutter(), darkDynamic, state.highContrast),
              themeMode: state.themeMode,
              locale: state.locale.isEmpty ? null : Locale(state.locale),
              localizationsDelegates: const [
                ...AppLocalizations.localizationsDelegates,
                LeapLocalizations.delegate,
                LocaleNamesLocalizationsDelegate(),
              ],
              builder: (context, child) {
                if (!state.nativeTitleBar) {
                  child = virtualWindowFrameBuilder(context, child);
                }
                return child ?? Container();
              },
              supportedLocales: AppLocalizations.supportedLocales,
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
                routes: [
                  GoRoute(
                    path: 'calendar',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => CalendarPage(
                        filter: state.extra is CalendarFilter
                            ? state.extra as CalendarFilter
                            : const CalendarFilter(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'events',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => const EventsPage(),
                    ),
                  ),
                  GoRoute(
                    path: 'groups',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => const GroupsPage(),
                    ),
                  ),
                  GoRoute(
                      path: 'notes',
                      pageBuilder: _fadeTransitionBuilder(
                        (context, state) => const NotesPage(),
                      ),
                      routes: [
                        GoRoute(
                          path: ':source/:id',
                          name: 'subnote',
                          pageBuilder: _fadeTransitionBuilder(
                            (context, state) => NotesPage(
                              parent: SourcedModel(
                                state.pathParameters['source']!,
                                Multihash.fromBase64Url(
                                    state.pathParameters['id']!),
                              ),
                            ),
                          ),
                        ),
                        GoRoute(
                          path: ':id',
                          name: 'subnote-local',
                          pageBuilder: _fadeTransitionBuilder(
                            (context, state) => NotesPage(
                              parent: SourcedModel(
                                '',
                                Multihash.fromBase64Url(
                                    state.pathParameters['id']!),
                              ),
                            ),
                          ),
                        )
                      ]),
                  GoRoute(
                    path: 'places',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => const PlacesPage(),
                    ),
                  ),
                  GoRoute(
                    path: 'users',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => UsersPage(
                        filter: state.extra is UserFilter
                            ? state.extra as UserFilter
                            : const UserFilter(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'sources',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => const SourcesPage(),
                    ),
                  ),
                  GoRoute(
                    path: 'settings',
                    pageBuilder: _fadeTransitionBuilder(
                      (context, state) => const SettingsPage(),
                    ),
                  ),
                ]),
          ]),
    ],
  );
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Flow Nightly' : 'Flow';
const applicationName = 'Linwood $shortApplicationName';
