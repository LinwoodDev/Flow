import 'package:flow_app/teams/details.dart';
import 'package:flow_app/teams/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TeamsModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => TeamsPage()),
    ChildRoute('/create', child: (_, __) => TeamPage())
  ];
}
