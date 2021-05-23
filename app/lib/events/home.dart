import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        pageTitle: "Events",
        page: RoutePages.events,
        body: Container(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed("/events/create"),
            label: Text("Create event"),
            icon: Icon(PhosphorIcons.plusLight)));
  }
}
