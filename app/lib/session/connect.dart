import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connect")),
      body: Scrollbar(
          child: Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 1000),
                  child: ListView(children: [
                    TextField(
                        controller: _urlController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(labelText: "URL", hintText: "example.com"))
                  ])))),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check_outlined),
          onPressed: () {
            Modular.to.pushNamed(Uri(
                pathSegments: ["", "session", "login"],
                queryParameters: {"url": _urlController.text}).toString());
          }),
    );
  }
}

Future<bool> connect(String host) async {
  var response = await http.get(Uri.https(host, ""));
  var data = json.decode(response.body);
  return data['application'] == "Linwood-Flow";
}
