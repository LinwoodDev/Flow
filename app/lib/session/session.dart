import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/config/main.dart';

import 'display.dart';
import 'login.dart';
import 'register.dart';

class SessionPage extends StatefulWidget {
  final String address;
  final MainConfig mainConfig;

  const SessionPage({Key? key, required this.address, required this.mainConfig})
      : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TextEditingController _urlController;

  @override
  void initState() {
    super.initState();

    _urlController = TextEditingController(text: widget.address);
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
              const SizedBox(height: 20),
              SessionDisplay(mainConfig: widget.mainConfig),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: TextField(
                      controller: _urlController,
                      readOnly: true,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "URL",
                          hintText: "https://example.com",
                          prefixIcon: Icon(PhosphorIcons.linkLight)))),
              const SizedBox(height: 50),
              Expanded(
                  child: TabBarView(children: [
                LoginPage(address: widget.address),
                RegisterPage(address: widget.address)
              ]))
            ])));
  }
}
