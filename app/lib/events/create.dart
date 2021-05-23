import 'package:flow_app/widgets/date.dart';
import 'package:flow_app/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  String? server = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(children: [
                SizedBox(height: 50),
                DropdownButtonFormField<String>(
                    value: server,
                    decoration: InputDecoration(labelText: "Server", border: OutlineInputBorder()),
                    onChanged: (value) => setState(() => server = value),
                    items: [
                      ...Hive.box<String>('servers')
                          .values
                          .map((e) => DropdownMenuItem(child: Text(e), value: e)),
                      DropdownMenuItem(child: Text("Local"), value: "")
                    ]),
                TextField(decoration: InputDecoration(labelText: "Name")),
                TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    maxLines: null,
                    minLines: 3),
                SizedBox(height: 50),
                Text("Start"),
                Row(children: [
                  Expanded(child: DateInputField()),
                  Expanded(child: TimeInputField())
                ]),
                SizedBox(height: 50),
                Text("End"),
                Row(children: [
                  Expanded(child: DateInputField()),
                  Expanded(child: TimeInputField())
                ])
              ])),
        )),
        floatingActionButton:
            FloatingActionButton(child: Icon(PhosphorIcons.checkLight), onPressed: () {}),
        appBar: AppBar(title: Text("Create event")));
  }
}
