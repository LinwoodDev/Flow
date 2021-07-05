import 'package:flow_app/users/details.dart';
import 'package:flow_app/users/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const UsersPage()),
    ChildRoute('/create', child: (_, __) => const UserPage()),
    ChildRoute("/details",
        child: (_, __) => UserPage(id: int.tryParse(Modular.args?.queryParams['id'] ?? "0")))
  ];
}
