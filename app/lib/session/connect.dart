import 'dart:convert';

import 'package:flow_app/session/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/config/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

class ConnectPage extends StatefulWidget {
  final bool inIntro;

  const ConnectPage({Key? key, this.inIntro = false}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage>
    with TickerProviderStateMixin {
  WebSocketChannel? channel;
  MainConfig? config;
  bool _secure = true;
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (channel != null && config != null) {
      return SessionPage(
          channel: channel!, address: _urlController.text, mainConfig: config!);
    }
    String scheme = _secure ? "wss://" : "ws://";
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
                  CheckboxListTile(
                      title: const Text("Secure"),
                      value: _secure,
                      onChanged: (value) =>
                          setState(() => _secure = value ?? _secure)),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "URL $scheme",
                          hintText: "example.com")),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          child: const Text("USE LOCAL"),
                          onPressed: () {
                            print("INTRO!");
                            Hive.box('settings').put("intro", true);
                            Modular.to.navigate("/");
                          }),
                    ],
                  ),
                ]))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(PhosphorIcons.checkLight),
            onPressed: () async {
              var uri =
                  Uri.parse(_secure ? "wss://" : "ws://${_urlController.text}");
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
