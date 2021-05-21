import 'package:flow_app/events/create.dart';
import 'package:flow_app/events/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EventsModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => EventsPage()),
    ChildRoute('/create', child: (_, __) => CreateEventPage())
  ];
}
