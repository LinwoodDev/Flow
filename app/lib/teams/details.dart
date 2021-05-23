import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/team.dart';

class TeamPage extends StatefulWidget {
  final Team? team;

  const TeamPage({Key? key, this.team}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  String? server = "";
  @override
  Widget build(BuildContext context) {
    var create = widget.team == null;
    return Scaffold(
      appBar: AppBar(title: Text(create ? "Create team" : widget.team!.name)),
      floatingActionButton:
          FloatingActionButton(child: Icon(PhosphorIcons.checkLight), onPressed: () {}),
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
    );
  }
}
