import 'package:flow_app/widgets/date.dart';
import 'package:flow_app/widgets/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/event.dart';

class EventPage extends StatefulWidget {
  final Event? event;
  final int? id;
  final bool isDesktop;

  const EventPage({Key? key, this.event, this.isDesktop = false, this.id}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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
                if (widget.isDesktop && widget.id != null)
                  ElevatedButton.icon(
                      onPressed: () => Modular.to.pushNamed(Uri(
                          pathSegments: ["", "events", "details"],
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
        floatingActionButton: FloatingActionButton(
            heroTag: "event-check", child: Icon(PhosphorIcons.checkLight), onPressed: () {}),
        appBar: widget.isDesktop
            ? null
            : AppBar(title: Text(create ? "Create event" : widget.event!.name)));
  }
}
