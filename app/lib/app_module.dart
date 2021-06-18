// app_module.dart
import 'package:flow_app/admin/home.dart';
import 'package:flow_app/badges/module.dart';
import 'package:flow_app/calendar.dart';
import 'package:flow_app/events/module.dart';
import 'package:flow_app/home.dart';
import 'package:flow_app/overview.dart';
import 'package:flow_app/seasons/module.dart';
import 'package:flow_app/session/module.dart';
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
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/overview', child: (_, __) => OverviewPage()),
    ChildRoute('/calendar', child: (_, __) => CalendarPage()),
    ModuleRoute('/events', module: EventsModule()),
    ModuleRoute('/tasks', module: TasksModule()),
    ModuleRoute('/teams', module: TeamsModule()),
    ModuleRoute('/users', module: UsersModule()),
    ModuleRoute('/seasons', module: SeasonsModule()),
    ModuleRoute('/badges', module: BadgesModule()),
    ChildRoute('/admin', child: (_, __) => AdminPage()),
    ModuleRoute('/session', module: SessionModule()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}
