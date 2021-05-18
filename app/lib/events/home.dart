import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(pageTitle: "Events", page: RoutePages.events, body: Container());
  }
}
