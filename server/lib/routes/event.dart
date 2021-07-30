import 'dart:convert';
import 'dart:io';

import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/local/service.dart';

import '../server_route.dart';

const eventsSubs = <WebSocket>[];
const openedEventsSubs = <WebSocket>[];
const plannedEventsSubs = <WebSocket>[];
const doneEventsSubs = <WebSocket>[];
const eventSubs = <WebSocket, int>{};

Future<bool> handleEventSockets(ServerRoute route) async {
  final service = GetIt.I.get<LocalService>().events;
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
    case "events:subscribe-opened":
      if (route is SocketRoute) {
        openedEventsSubs.add(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribed-opened":
      if (route is SocketRoute) {
        route.reply(value: openedEventsSubs.contains(route.socket));
      }
      break;
    case "events:unsubscribe-opened":
      if (route is SocketRoute) {
        openedEventsSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribe-planned":
      if (route is SocketRoute) {
        plannedEventsSubs.add(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribed-planned":
      if (route is SocketRoute) {
        route.reply(value: plannedEventsSubs.contains(route.socket));
      }
      break;
    case "events:unsubscribe-planned":
      if (route is SocketRoute) {
        plannedEventsSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribe-done":
      if (route is SocketRoute) {
        doneEventsSubs.add(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:subscribed-done":
      if (route is SocketRoute) {
        route.reply(value: doneEventsSubs.contains(route.socket));
      }
      break;
    case "events:unsubscribe-done":
      if (route is SocketRoute) {
        doneEventsSubs.remove(route.socket);
      }
      route.reply(value: "success");
      break;
    case "events:fetch":
      route.reply(value: await service.fetchEvents().then((value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "events:fetch-opened":
      route.reply(value: await service.fetchOpenedEvents().then((value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "events:fetch-done":
      route.reply(value: await service.fetchDoneEvents().then((value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "events:fetch-planned":
      route.reply(value: await service.fetchPlannedEvents().then((value) => value.map((e) => e.toJson(addId: true)).toList()));
      break;
    case "event:subscribe":
      var id = route.value as int?;
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return true;
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
        return true;
      }
      var event = await service.fetchEvent(id);
      route.reply(value: event?.toJson());
      break;
    case "event:create":
    case "events:create":
      var event = Event.fromJson(json.decode(route.value ?? ""));
      event = await service.createEvent(event);
      route.reply(value: event.toJson(addId: true));
      break;
    case "event:update":
      var event = Event.fromJson(json.decode(route.value ?? ""));
      await service.updateEvent(event);
      route.reply(value: event.toJson(addId: true));
      break;
    case "event:delete":
      var id = int.tryParse(route.value ?? "");
      if (id == null) {
        route.reply(exception: InputException([InputError("invalid")]));
        return true;
      }
      await service.deleteEvent(id);
      route.reply();
      break;
    default:
      return false;
  }
  return true;
}
