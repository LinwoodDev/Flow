import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/badge.dart';

class BadgePage extends StatefulWidget {
  final Badge? event;

  const BadgePage({Key? key, this.event}) : super(key: key);

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  String? server = "";

  @override
  Widget build(BuildContext context) {
    var create = widget.event == null;
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
                SizedBox(height: 50),
                TextField(decoration: InputDecoration(labelText: "Name")),
                TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    maxLines: null,
                    minLines: 3)
              ])),
        )),
        floatingActionButton:
            FloatingActionButton(child: Icon(PhosphorIcons.checkLight), onPressed: () {}),
        appBar: AppBar(title: Text(create ? "Create badge" : widget.event!.name)));
  }
}
