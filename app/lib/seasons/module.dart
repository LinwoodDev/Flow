import 'package:flow_app/seasons/details.dart';
import 'package:flow_app/seasons/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SeasonsModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => SeasonsPage()),
    ChildRoute('/create', child: (_, __) => SeasonPage()),
    ChildRoute("/details", child: (_, __) => SeasonPage(id: int.tryParse(Modular.args?.queryParams['id'] ?? "0")))
  ];
}
