import 'package:flow_app/widgets/drawer.dart';
import 'package:flow_app/widgets/server.dart';
import 'package:flutter/material.dart';

class PropertiesSettingsPage extends StatefulWidget {
  @override
  _PropertiesSettingsPageState createState() => _PropertiesSettingsPageState();
}

class _PropertiesSettingsPageState extends State<PropertiesSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.properties,
        body: ServerView(
            builder: (server) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: Column(
                        children: [TextField(decoration: InputDecoration(labelText: "Name"))])))));
  }
}
