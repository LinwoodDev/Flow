import 'package:flutter/material.dart';

class GeneralAdminSettingsPage extends StatelessWidget {
  final String server;

  const GeneralAdminSettingsPage({Key? key, required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            padding: const EdgeInsets.all(16.0),
            child: Column(children: const [
              TextField(decoration: InputDecoration(labelText: "Name")),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                minLines: 3,
                maxLines: null,
              )
            ])));
  }
}
