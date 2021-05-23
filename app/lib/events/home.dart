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
        page: RoutePages.events,
        pageTitle: "Events",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        floatingActionButton: FloatingActionButton.extended(
            label: Text("Create event"),
            icon: Icon(PhosphorIcons.plusLight),
            onPressed: () => Modular.to.pushNamed("/events/create")),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
                    children: List.generate(10,
                        (index) => ListTile(title: Text((index + 1).toString()), onTap: () {}))))));
  }
}
