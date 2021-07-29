import 'dart:convert';
import 'dart:io';

import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/local_service.dart';

import '../server_route.dart';

const eventsSubs = <WebSocket>[];
const eventSubs = <WebSocket, int>{};

Future<void> handleEventSockets(ServerRoute route) async {
  final service = GetIt.I.get<LocalService>();
  WebSocket? ws;
  if (route is SocketRoute) {
    ws = route.socket;
  }
  final jwtService = GetIt.I.get<JWTService>();

  final token = jwtService.verify(route.auth);
  if (route.path.startsWith("event") && token?.subject == null && ws != null) {
    route.reply(exception: InputException([InputError("unauthorized")]));
    return;
  }
  switch (route.path) {
    case "events:subscribe":
      if (route is SocketRoute) {
        eventsSubs.add(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribed":
      if (route is SocketRoute) {
        route.reply(value: eventsSubs.contains(route.socket));
      }
      break;
    case "events:unsubscribe":
      if (route is SocketRoute) {
        eventsSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:fetch":
      route.reply(value: await service.fetchEvents().then((value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "event:subscribe":
      var id = route.value as int?;
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return;
      }
      if (route is SocketRoute) {
        eventSubs[route.socket] = id;
      }
      route.reply(value: "success");
      break;
    case "event:subscribed":
      if (route is SocketRoute) {
        route.reply(value: eventSubs[route.socket]);
      }
      break;
    case "event:unsubscribe":
      if (route is SocketRoute) {
        eventSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "event:fetch":
      var id = int.tryParse(route.value ?? "");
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return;
      }
      var event = await service.fetchEvent(id);
      route.reply(value: event?.toJson());
      break;
    case "event:create":
    case "events:create":
      var event = Event.fromJson(json.decode(route.value ?? ""));
      event = await service.createEvent(event);
      route.reply(value: event.toJson(addId: true));
  }
}
