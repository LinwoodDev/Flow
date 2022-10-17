import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flow/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      ),
      // Same definition for the dark theme, but using FlexThemeData.dark().
      darkTheme: FlexThemeData.dark(
        scheme: _usedScheme,
        useMaterial3: true,
        // Use a bit more themed elevated app bar in dark mode.
        appBarElevation: 2,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  );
}
