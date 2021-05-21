import 'package:flow_app/widgets/date.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flow_app/widgets/time.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Align(
          alignment: Alignment.topLeft,
          child: Container(
              constraints: BoxConstraints(maxHeight: 500),
              child: Column(children: [
                TextField(decoration: InputDecoration(labelText: "Name")),
                TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    maxLines: null,
                    minLines: 3),
                Row(
                  children: [
                    Expanded(child: DateInputField()),
                    Expanded(child: TimeInputField()),
                    Expanded(child: DateInputField()),
                    Expanded(child: TimeInputField()),
                  ],
                )
              ])),
        )),
        appBar: AppBar(title: Text("Create event")));
  }
}
