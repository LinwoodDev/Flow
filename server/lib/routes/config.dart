import 'dart:convert';
import 'dart:io';

import 'package:flow_server/services/config.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/config/main.dart';
import 'package:shared/exceptions/input.dart';

import '../server_route.dart';

Future<bool> handleConfigSockets(ServerRoute route) async {
  final service = GetIt.I.get<ConfigService>();
  WebSocket? ws;
  if (route is SocketRoute) {
    ws = route.socket;
  }
  final jwtService = GetIt.I.get<JWTService>();

  final token = jwtService.verify(route.auth);
  if (route.path.startsWith("event") && token?.subject == null && ws != null) {
    route.reply(exception: InputException([InputError("unauthorized")]));
    return true;
  }
  switch (route.path) {
    case "config:get":
      route.reply(value: service.mainConfig.toJson());
      break;
    case "config:update":
      service.mainConfig = MainConfig.fromJson(json.decode(route.value ?? ''));
      service.save();
      break;
    default:
      return false;
  }
  return true;
}
