import 'dart:async';

import '../server_route.dart';
import 'auth.dart';
import 'event.dart';
import 'user.dart';

Future<void> handleHomeSockets(ServerRoute route) async {
  switch (route.path) {
    case "info":
      route.reply(value: {
        'name': 'Linwood-Flow',
        'applications': ['events', 'teams', 'dev-doctor']
      });
  }
  if (route.path.startsWith("auth")) {
    await handleAuthSockets(route);
  }
  if (route.path.startsWith("user")) {
    await handleUserSockets(route);
  }
  if (route.path.startsWith("event")) {
    await handleEventSockets(route);
  }
}
