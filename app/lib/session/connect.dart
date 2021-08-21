import 'dart:convert';

import 'package:flow_app/session/session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/config/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectPage extends StatefulWidget {
  final bool inIntro;

  const ConnectPage({Key? key, this.inIntro = false}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

enum ConnectionType {
  wss, ws, local
}

class _ConnectPageState extends State<ConnectPage>
    with TickerProviderStateMixin {
  WebSocketChannel? channel;
  MainConfig? config;
  ConnectionType _connectionType = ConnectionType.wss;
  final TextEditingController _urlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if (channel != null && config != null) {
      return SessionPage(
          channel: channel!, address: _urlController.text, mainConfig: config!);
    }
    String scheme = "";
    if(_connectionType == ConnectionType.wss) {
      scheme = "wss://";
    }
    if(_connectionType == ConnectionType.ws) {
      scheme = "ws://";
    }
    return Scaffold(
        appBar: widget.inIntro ? null : AppBar(title: const Text("Connect")),
        body: Align(
            alignment: Alignment.center,
            child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView(shrinkWrap: true, children: [
                  const Image(
                      image: AssetImage("images/logo.png"), height: 200),
                  const SizedBox(height: 20),
                  if (widget.inIntro)
                    Text("Connect",
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ...ConnectionType.values.map((e) => RadioListTile<ConnectionType>(title: Text("${e.toString()[0].toUpperCase()}${e.toString().substring(1)}"), value: e, groupValue: _connectionType, onChanged: (value) => setState(() => _connectionType = value ?? _connectionType))),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,enabled: _connectionType != ConnectionType.local,
                      decoration: InputDecoration(filled: true,
                          labelText: "URL $scheme", hintText: "example.com"))
                ]))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () async {
              if(_connectionType == ConnectionType.local) {
                return;
              }
              var uri = Uri.parse(_connectionType == ConnectionType.wss ? "wss://" : "ws://"  + _urlController.text);
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
