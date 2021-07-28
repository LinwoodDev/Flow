import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PlacesAdminSettingsPage extends StatefulWidget {
  final String server;

  const PlacesAdminSettingsPage({Key? key, required this.server})
      : super(key: key);

  @override
  _PlacesAdminSettingsPageState createState() =>
      _PlacesAdminSettingsPageState();
}

class _PlacesAdminSettingsPageState extends State<PlacesAdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(PhosphorIcons.flagLight),
                  label: const Text("OPEN PERMISSIONS"))
            ])));
  }
}
