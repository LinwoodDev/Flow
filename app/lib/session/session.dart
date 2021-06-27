import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    var registerRoute = Modular.to.path.startsWith("/session/register");
    return DefaultTabController(
        length: 2,
        initialIndex: registerRoute ? 1 : 0,
        child: Scaffold(
            appBar: AppBar(
                title: Text("Session"),
                bottom: TabBar(
                    onTap: (index) async {
                      Modular.to.pushReplacementNamed(Uri(
                              pathSegments: ["", "session", index == 0 ? "login" : "register"],
                              queryParameters: Modular.args?.queryParams)
                          .toString());
                      setState(() {});
                    },
                    tabs: [Tab(icon: Icon(PhosphorIcons.signInLight)), Tab(icon: Icon(PhosphorIcons.userPlusLight))])),
            body: RouterOutlet()));
  }
}
