import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(pageTitle: "Teams", page: RoutePages.teams, body: Container());
  }
}
