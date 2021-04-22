import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect")),
      body: Scrollbar(
          child: Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: ListView(children: [
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test"),
                    Text("Test")
                  ])))),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.check_outlined), onPressed: () {}),
    );
  }
}

Future<bool> connect(String host) async {
  var response = await http.get(Uri.https(host, ""));
  var data = json.decode(response.body);
  return data['name'] == "Linwood-Flow";
}
