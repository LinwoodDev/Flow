import 'package:flow_app/widgets/drawer.dart';
import 'package:flow_app/widgets/server.dart';
import 'package:flutter/material.dart';

class RolesSettingsPage extends StatefulWidget {
  @override
  _RolesSettingsPageState createState() => _RolesSettingsPageState();
}

class _RolesSettingsPageState extends State<RolesSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.roles,
        floatingActionButton: FloatingActionButton.extended(
            label: Text("Create role"), icon: Icon(Icons.add_outlined), onPressed: () {}),
        body: ServerView(
            builder: (server) => Column(
                children: List.generate(
                    10, (index) => ListTile(title: Text((index + 1).toString()), onTap: () {})))));
  }
}
