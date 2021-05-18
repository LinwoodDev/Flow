// app_module.dart
import 'package:flow_app/settings/properties.dart';
import 'package:flow_app/settings/roles.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'appearance.dart';
import 'general.dart';
import 'servers.dart';

class SettingsModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => GeneralSettingsPage()),
    ChildRoute('/appearance', child: (_, __) => AppearanceSettingsPage()),
    ChildRoute('/servers', child: (_, __) => ServersSettingsPage()),
    ChildRoute('/roles', child: (_, __) => RolesSettingsPage()),
    ChildRoute('/properties', child: (_, __) => PropertiesSettingsPage())
  ];
}
