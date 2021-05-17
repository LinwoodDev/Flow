import 'package:flow_app/session/connect.dart';
import 'package:flow_app/session/session.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login.dart';
import 'register.dart';

class SessionModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/connect', child: (_, __) => ConnectPage()),
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => SessionPage(),
      children: [
        ChildRoute("/login", child: (_, __) => LoginPage()),
        ChildRoute('/register', child: (_, __) => RegisterPage())
      ],
    ),
  ];
}
