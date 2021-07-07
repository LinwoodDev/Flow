import 'dart:convert';

import 'package:flow_app/session/session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connect")),
      body: Scrollbar(
          child: Center(
              child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ListView(children: [
                    TextField(
                        controller: _urlController,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(labelText: "URL", hintText: "https://example.com"))
                  ])))),
      floatingActionButton: FloatingActionButton(
          child: const Icon(PhosphorIcons.checkLight),
          onPressed: () async {
            try {
              var uri = Uri.parse(_urlController.text);

              var response = await http.get(uri);
              var data = json.decode(response.body);
              if (data['name'] == "Linwood-Flow") {
                Modular.to.push(MaterialPageRoute(builder: (context) => SessionPage(address: _urlController.text)));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: const Text("Invalid flow server"),
                        actions: [TextButton(child: const Text("CLOSE"), onPressed: () => Modular.to.pop())]));
              }
            } catch (e) {
              print("Error: $e");
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text("Error while connecting to the server"),
                      actions: [TextButton(child: const Text("CLOSE"), onPressed: () => Modular.to.pop())]));
            }
          }),
    );
  }
}
