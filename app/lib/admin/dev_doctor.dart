import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DevDoctorAdminSettingsPage extends StatefulWidget {
  final String server;

  const DevDoctorAdminSettingsPage({Key? key, required this.server}) : super(key: key);

  @override
  _DevDoctorAdminSettingsPageState createState() => _DevDoctorAdminSettingsPageState();
}

class _DevDoctorAdminSettingsPageState extends State<DevDoctorAdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              ElevatedButton.icon(
                  onPressed: () {}, icon: Icon(PhosphorIcons.flagLight), label: Text("OPEN PERMISSIONS"))
            ])));
  }
}
