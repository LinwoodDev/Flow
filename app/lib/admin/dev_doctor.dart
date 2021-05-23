import 'package:flutter/material.dart';

class DevDoctorAdminSettingsPage extends StatefulWidget {
  final String server;

  const DevDoctorAdminSettingsPage({Key? key, required this.server}) : super(key: key);

  @override
  _DevDoctorAdminSettingsPageState createState() => _DevDoctorAdminSettingsPageState();
}

class _DevDoctorAdminSettingsPageState extends State<DevDoctorAdminSettingsPage> {
  bool enabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Column(children: [
              CheckboxListTile(
                  value: enabled,
                  onChanged: (value) {
                    setState(() {
                      enabled = value!;
                    });
                  },
                  title: Text("Enabled")),
              TextField(decoration: InputDecoration(labelText: "Name")),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                minLines: 3,
                maxLines: null,
              )
            ])));
  }
}
