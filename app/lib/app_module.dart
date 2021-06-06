// app_module.dart
import 'package:flow_app/admin/home.dart';
import 'package:flow_app/badges/module.dart';
import 'package:flow_app/events/module.dart';
import 'package:flow_app/home.dart';
import 'package:flow_app/session/module.dart';
import 'package:flow_app/settings/module.dart';
import 'package:flow_app/teams/module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ModuleRoute('/events', module: EventsModule()),
    ModuleRoute('/teams', module: TeamsModule()),
    ModuleRoute('/badges', module: BadgesModule()),
    ChildRoute('/admin', child: (_, __) => AdminPage()),
    ModuleRoute('/session', module: SessionModule()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}
