import 'package:flow_app/widgets/drawer.dart';
import 'package:flow_app/widgets/server.dart';
import 'package:flutter/material.dart';

class TeamsPage extends StatefulWidget {
  @override
  _TeamsPageState createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.teams,
        floatingActionButton: FloatingActionButton.extended(
            label: Text("Create team"), icon: Icon(Icons.add_outlined), onPressed: () {}),
        body: ServerView(
            builder: (server) => Scrollbar(
                child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(
                            10,
                            (index) =>
                                ListTile(title: Text((index + 1).toString()), onTap: () {})))))));
  }
}
