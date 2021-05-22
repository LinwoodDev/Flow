import 'package:flutter/material.dart';

class EventsAdminSettingsPage extends StatelessWidget {
  final String server;

  const EventsAdminSettingsPage({Key? key, required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
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
            ])));
  }
}
