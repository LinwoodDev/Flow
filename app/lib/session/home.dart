import 'package:flow_app/session/display.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/config/main.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'login.dart';
import 'register.dart';

class SessionPage extends StatefulWidget {
  final String address;
  final MainConfig mainConfig;
  final WebSocketChannel channel;

  const SessionPage(
      {Key? key,
      required this.address,
      required this.mainConfig,
      required this.channel})
      : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  void dispose() {
    widget.channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: const Text("Session"),
                bottom: const TabBar(tabs: [
                  Tab(icon: Icon(PhosphorIcons.signInLight), text: "Log In"),
                  Tab(icon: Icon(PhosphorIcons.userPlusLight), text: "Register")
                ])),
            body: Column(children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(children: [
                    const SizedBox(height: 20),
                    SessionDisplay(mainConfig: widget.mainConfig),
                    const SizedBox(height: 20),
                    const Divider()
                  ])),
              Expanded(
                  child: TabBarView(children: [
                LoginPage(address: widget.address, channel: widget.channel),
                RegisterPage(address: widget.address, channel: widget.channel)
              ]))
            ])));
  }
}
