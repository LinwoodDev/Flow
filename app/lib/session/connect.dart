import 'dart:convert';

import 'package:flow_app/session/session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/config/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  WebSocketChannel? channel;
  MainConfig? config;
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (channel != null && config != null) {
      return SessionPage(
          channel: channel!, address: _urlController.text, mainConfig: config!);
    }
    return Scaffold(
        appBar: AppBar(title: const Text("Connect")),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView(children: [
                  TextField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                          labelText: "URL", hintText: "wss://example.com")),
                ]))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () async {
              var uri = Uri.parse(_urlController.text);
              var channel = WebSocketChannel.connect(uri);

              channel.sink.add(json.encode({"route": "info"}));
              channel.stream
                  .firstWhere((event) => json.decode(event)['route'] == "info")
                  .then((response) {
                var data = json.decode(response);
                var config = MainConfig.fromJson(data['data']);

                if (data['data']['application'] == "Linwood-Flow") {
                  setState(() {
                    this.channel = channel;
                    this.config = config;
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: const Text("Invalid flow server"),
                              actions: [
                                TextButton(
                                    child: const Text("CLOSE"),
                                    onPressed: () => Modular.to.pop())
                              ]));
                }
              }, onError: (e) {
                print("Error: $e");
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: const Text(
                                "Error while connecting to the server"),
                            actions: [
                              TextButton(
                                  child: const Text("CLOSE"),
                                  onPressed: () => Modular.to.pop())
                            ]));
              });
            }));
  }
}
