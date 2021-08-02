import 'dart:async';

import 'package:flow_server/routes/config.dart';
import 'package:flow_server/services/config.dart';
import 'package:get_it/get_it.dart';

import '../server_route.dart';
import 'auth.dart';
import 'event.dart';
import 'user.dart';

Future<bool> handleHomeSockets(ServerRoute route) async {
  var mainConfig = GetIt.I.get<ConfigService>().mainConfig;
  switch (route.path) {
    case "":
    case "info":
      route.reply(
          value: mainConfig.toJson(limited: true)
            ..addAll({'application': 'Linwood-Flow'}));
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
      if (route.path.startsWith("config")) {
        return await handleConfigSockets(route);
      }
      return false;
  }
  return true;
}
