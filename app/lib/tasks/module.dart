import 'package:flow_app/tasks/details.dart';
import 'package:flow_app/tasks/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TasksModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => TasksPage()),
    ChildRoute('/create', child: (_, __) => TaskPage()),
    ChildRoute("/details",
        child: (_, __) => TaskPage(id: int.tryParse(Modular.args?.queryParams['id'] ?? "0")))
  ];
}
