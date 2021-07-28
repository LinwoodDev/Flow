import 'dart:async';
import 'dart:convert';

import 'package:flow_server/routes/profile.dart';

import '../socket_route.dart';
import 'auth.dart';

Future<void> handleHomeSockets(SocketRoute route) async {
  switch (route.path) {
    case "info":
      route.reply(
          value: json.encode({
        'name': 'Linwood-Flow',
        'applications': ['events', 'teams', 'dev-doctor']
      }));
  }
  handleAuthSockets(route);
  handleProfileSockets(route);
}
