// app_module.dart
import 'package:flow/admin/home.dart';
import 'package:flow/badges/module.dart';
import 'package:flow/events/module.dart';
import 'package:flow/home.dart';
import 'package:flow/intro.dart';
import 'package:flow/session/connect.dart';
import 'package:flow/settings/module.dart';
import 'package:flow/tasks/module.dart';
import 'package:flow/teams/module.dart';
import 'package:flow/users/module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', guards: [IntroGuard()], child: (_, __) => const HomePage()),
    ChildRoute("/intro", child: (_, __) => const IntroPage()),
    ModuleRoute('/events', guards: [IntroGuard()], module: EventsModule()),
    ModuleRoute('/tasks', guards: [IntroGuard()], module: TasksModule()),
    ModuleRoute('/teams', guards: [IntroGuard()], module: TeamsModule()),
    ModuleRoute('/users', guards: [IntroGuard()], module: UsersModule()),
    ModuleRoute('/badges', guards: [IntroGuard()], module: BadgesModule()),
    ChildRoute('/admin',
        guards: [IntroGuard()], child: (_, __) => const AdminPage()),
    ChildRoute('/connect',
        guards: [IntroGuard()], child: (_, __) => const ConnectPage()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}

class IntroGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Hive.box('settings').get("intro", defaultValue: false);
  }

  IntroGuard() : super(redirectTo: "/intro");
}
