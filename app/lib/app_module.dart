// app_module.dart
import 'package:flow_app/events/home.dart';
import 'package:flow_app/session/module.dart';
import 'package:flow_app/settings/module.dart';
import 'package:flow_app/teams/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => MyHomePage()),
    ChildRoute('/events', child: (_, __) => EventsPage()),
    ChildRoute('/teams', child: (_, __) => TeamsPage()),
    ModuleRoute('/session', module: SessionModule()),
    ModuleRoute("/settings", module: SettingsModule())
  ];
}
