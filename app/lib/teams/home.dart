import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.teams,
        pageTitle: "Teams",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        floatingActionButton: FloatingActionButton.extended(
            label: Text("Create team"),
            icon: Icon(PhosphorIcons.plusLight),
            onPressed: () => Modular.to.pushNamed("/teams/create")),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
                    children: List.generate(10,
                        (index) => ListTile(title: Text((index + 1).toString()), onTap: () {}))))));
  }
}
