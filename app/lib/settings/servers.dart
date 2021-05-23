import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ServersSettingsPage extends StatefulWidget {
  @override
  _ServersSettingsPageState createState() => _ServersSettingsPageState();
}

class _ServersSettingsPageState extends State<ServersSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.servers,
        pageTitle: "Servers",
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed("/session/connect"),
            label: Text("Add server"),
            icon: Icon(PhosphorIcons.plusLight)),
        body: ListView.builder(
          itemCount: 0,
          itemBuilder: (BuildContext context, int index) => ListTile(),
        ));
  }
}
