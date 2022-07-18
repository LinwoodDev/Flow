import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EventsAdminSettingsPage extends StatefulWidget {
  final String server;

  const EventsAdminSettingsPage({Key? key, required this.server})
      : super(key: key);

  @override
  _EventsAdminSettingsPageState createState() =>
      _EventsAdminSettingsPageState();
}

class _EventsAdminSettingsPageState extends State<EventsAdminSettingsPage> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        actions: [
          Switch(
              onChanged: (bool value) => setState(() => enabled = value),
              value: enabled)
        ],
      ),
      body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(PhosphorIcons.flagLight),
                    label: const Text("OPEN PERMISSIONS"))
              ]))),
    );
  }
}
