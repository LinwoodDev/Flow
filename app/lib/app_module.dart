// app_module.dart
import 'package:flow_app/admin/home.dart';
import 'package:flow_app/badges/module.dart';
import 'package:flow_app/events/module.dart';
import 'package:flow_app/home.dart';
import 'package:flow_app/intro/home.dart';
import 'package:flow_app/service/account.dart';
import 'package:flow_app/session/connect.dart';
import 'package:flow_app/settings/module.dart';
import 'package:flow_app/tasks/module.dart';
import 'package:flow_app/teams/module.dart';
import 'package:flow_app/users/module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', guards: [AuthGuard()], child: (_, __) => const HomePage()),
    ChildRoute("/intro", child: (_, __) => const IntroPage()),
    ModuleRoute('/events', guards: [AuthGuard()], module: EventsModule()),
    ModuleRoute('/tasks', guards: [AuthGuard()], module: TasksModule()),
    ModuleRoute('/teams', guards: [AuthGuard()], module: TeamsModule()),
    ModuleRoute('/users', guards: [AuthGuard()], module: UsersModule()),
    ModuleRoute('/badges', guards: [AuthGuard()], module: BadgesModule()),
    ChildRoute('/admin',
        guards: [AuthGuard()], child: (_, __) => const AdminPage()),
    ChildRoute('/connect',
        guards: [AuthGuard()], child: (_, __) => const ConnectPage()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}

class AuthGuard implements RouteGuard {
  @override
  Future<bool> canActivate(String url, ModularRoute route) async {
    print(GetIt.I.get<AccountService>().account);
    return GetIt.I.get<AccountService>().account != null;
  }

  @override
  String? get guardedRoute => "/intro";
}
