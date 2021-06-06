import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/badge.dart';

class BadgePage extends StatefulWidget {
  final Badge? badge;
  final int? id;
  final bool isDesktop;

  const BadgePage({Key? key, this.badge, this.id, this.isDesktop = false}) : super(key: key);

  @override
  _BadgePageState createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  String? server = "";

  @override
  Widget build(BuildContext context) {
    var create = widget.badge == null;
    return Scaffold(
        body: SingleChildScrollView(
            child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: Column(children: [
                if (widget.isDesktop && widget.id != null)
                  ElevatedButton.icon(
                      onPressed: () => Modular.to.pushNamed(Uri(
                          pathSegments: ["", "badges", "details"],
                          queryParameters: {"id": widget.id.toString()}).toString()),
                      icon: Icon(PhosphorIcons.arrowSquareOutLight),
                      label: Text("OPEN IN NEW WINDOW")),
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
        floatingActionButton: FloatingActionButton(
            heroTag: "badges-check", child: Icon(PhosphorIcons.checkLight), onPressed: () {}),
        appBar: widget.isDesktop
            ? null
            : AppBar(title: Text(create ? "Create badge" : widget.badge!.name)));
  }
}
