// app_module.dart
import 'package:flow_app/admin/home.dart';
import 'package:flow_app/badges/module.dart';
import 'package:flow_app/events/module.dart';
import 'package:flow_app/home.dart';
import 'package:flow_app/seasons/module.dart';
import 'package:flow_app/session/connect.dart';
import 'package:flow_app/settings/module.dart';
import 'package:flow_app/tasks/module.dart';
import 'package:flow_app/teams/module.dart';
import 'package:flow_app/users/module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
    ModuleRoute('/events', module: EventsModule()),
    ModuleRoute('/tasks', module: TasksModule()),
    ModuleRoute('/teams', module: TeamsModule()),
    ModuleRoute('/users', module: UsersModule()),
    ModuleRoute('/seasons', module: SeasonsModule()),
    ModuleRoute('/badges', module: BadgesModule()),
    ChildRoute('/admin', child: (_, __) => const AdminPage()),
    ChildRoute('/connect', child: (_, __) => const ConnectPage()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}
