import 'dart:async';

import '../server_route.dart';
import 'auth.dart';
import 'event.dart';
import 'user.dart';

Future<bool> handleHomeSockets(ServerRoute route) async {
  switch (route.path) {
    case "info":
      route.reply(value: {
        'name': 'Linwood-Flow',
        'applications': ['events', 'teams', 'dev-doctor']
      });
      break;
    default:
      if (route.path.startsWith("auth")) {
        return await handleAuthSockets(route);
      }
      if (route.path.startsWith("user")) {
        return await handleUserSockets(route);
      }
      if (route.path.startsWith("event")) {
        return await handleEventSockets(route);
      }
      return false;
  }
  return true;
}
