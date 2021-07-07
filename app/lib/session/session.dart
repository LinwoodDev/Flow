import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'login.dart';
import 'register.dart';

class SessionPage extends StatelessWidget {
  final String address;

  const SessionPage({Key? key, required this.address}) : super(key: key);

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
            body: TabBarView(children: [LoginPage(address: address), RegisterPage(address: address)])));
  }
}
