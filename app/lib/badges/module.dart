import 'package:flow_app/badges/details.dart';
import 'package:flow_app/badges/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BadgesModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const BadgesPage()),
    ChildRoute('/create', child: (_, __) => const BadgePage()),
    ChildRoute("/details",
        child: (_, __) =>
            BadgePage(id: int.tryParse(Modular.args?.queryParams['id'] ?? "0")))
  ];
}
