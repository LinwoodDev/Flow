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
    ChildRoute('/', child: (_, __) => const GeneralSettingsPage()),
    ChildRoute('/appearance', child: (_, __) => const AppearanceSettingsPage()),
    ChildRoute('/accounts', child: (_, __) => const AccountsSettingsPage())
  ];
}
