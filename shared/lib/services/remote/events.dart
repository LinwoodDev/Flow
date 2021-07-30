import 'dart:async';
import 'dart:io';

import 'package:shared/exceptions/input.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/api_service.dart';

class EventsRemoteService extends EventsApiService {
  final WebSocket ws;

  EventsRemoteService(this.ws);

  @override
  Future<Event> createEvent(Event event) async {
    ws.add({"route":"events:create", "value": event.toJson()});
    return ws.map((value) {
      var data = value as Map<String, dynamic>;
      if(data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
      return Event.fromJson(data);
    }).first;
  }

  @override
  Future<void> deleteEvent(int id) {
    ws.add({"route":"events:create", "value": id});
    return ws.map((value) {
      var data = value as Map<String, dynamic>;
      if(data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
    }).first;
  }

  @override
  Future<List<Event>> fetchDoneEvents() {
    // TODO: implement fetchDoneEvents
    throw UnimplementedError();
  }

  @override
  Future<Event?> fetchEvent(int id) {
    // TODO: implement fetchEvent
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchEvents() {
    // TODO: implement fetchEvents
    throw UnimplementedError();
  }

  @override
  Future<int> fetchEventsCount() {
    // TODO: implement fetchEventsCount
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchOpenedEvents() {
    // TODO: implement fetchOpenedEvents
    throw UnimplementedError();
  }

  @override
  Future<List<Event>> fetchPlannedEvents() {
    // TODO: implement fetchPlannedEvents
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onDoneEvents() {
    // TODO: implement onDoneEvents
    throw UnimplementedError();
  }

  @override
  Stream<Event?> onEvent(int id) {
    // TODO: implement onEvent
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onEvents() {
    // TODO: implement onEvents
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onOpenedEvents() {
    // TODO: implement onOpenedEvents
    throw UnimplementedError();
  }

  @override
  Stream<List<Event>> onPlannedEvents() {
    // TODO: implement onPlannedEvents
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}