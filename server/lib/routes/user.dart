import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local/service.dart';

import '../server_route.dart';

const usersSubs = <WebSocket>[];
const userSubs = <WebSocket, int>{};

Future<bool> handleUserSockets(ServerRoute route) async {
  final service = GetIt.I.get<LocalService>().users;
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
  User? user;
  if (token != null) {
    user = await service.fetchUser(int.parse(token.subject!, radix: 16));
  }
  switch (route.path) {
    case "users:subscribe":
      if (route is SocketRoute) {
        usersSubs.add(route.socket);
      }
      route.reply(value: "success");
      break;
    case "users:subscribed":
      if (route is SocketRoute) {
        route.reply(value: usersSubs.contains(route.socket));
      }
      break;
    case "users:unsubscribe":
      if (route is SocketRoute) {
        usersSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "users:fetch":
      route.reply(
          value: await service.fetchUsers().then(
              (value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "user:info":
      route.reply(value: user?.toJson(addId: true));
      break;
    case "user:create":
    case "users:create":
      var user = User.fromJson(json.decode(route.value ?? ""));
      user = await service.createUser(user);
      route.reply(value: user.toJson(addId: true));
      break;
    case "user:fetch":
      var id = int.tryParse(route.value ?? "");
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return true;
      }
      var event = await service.fetchUser(id);
      route.reply(value: event?.toJson());
      break;
    case "user:update":
      var user = User.fromJson(json.decode(route.value ?? ""));
      await service.updateUser(user);
      route.reply(value: user.toJson(addId: true));
      break;
    case "user:delete":
      var id = int.tryParse(route.value ?? "");
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return true;
      }
      await service.deleteUser(id);
      route.reply();
      break;
    default:
      return false;
  }
  return true;
/*
    return _buildPipeline(request, (request) async {
      var authDetails = request.context["authDetails"] as JWT;
      var id = int.parse(authDetails.subject!, radix: 16);
      var user = await GetIt.I.get<LocalService>().fetchUser(id);
      return Response.ok(json.encode(user?.toJson(addId: true)), headers: jsonHeaders);
    });*/
}
