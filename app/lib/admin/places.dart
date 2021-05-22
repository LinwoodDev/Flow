import 'package:flutter/material.dart';

class PlacesAdminSettingsPage extends StatefulWidget {
  final String server;

  const PlacesAdminSettingsPage({Key? key, required this.server}) : super(key: key);

  @override
  _PlacesAdminSettingsPageState createState() => _PlacesAdminSettingsPageState();
}

class _PlacesAdminSettingsPageState extends State<PlacesAdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: Column(children: [
                      TextField(decoration: InputDecoration(labelText: "Name")),
                      TextField(
                        decoration: InputDecoration(labelText: "Description"),
                        minLines: 3,
                        maxLines: null,
                      )
                    ])))));
  }
}
