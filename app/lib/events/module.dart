import 'package:flow_app/events/details.dart';
import 'package:flow_app/events/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EventsModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const EventsPage()),
    ChildRoute('/create', child: (_, __) => const EventPage()),
    ChildRoute("/details",
        child: (_, __) =>
            EventPage(id: int.tryParse(Modular.args.queryParams['id'] ?? "0")))
  ];
}
