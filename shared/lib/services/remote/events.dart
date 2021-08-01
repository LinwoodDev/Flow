import 'dart:async';

import 'package:shared/exceptions/input.dart';
import 'package:shared/models/event.dart';
import 'package:shared/services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class EventsRemoteService extends EventsApiService {
  final WebSocketChannel channel;

  EventsRemoteService(this.channel);

  @override
  Future<Event> createEvent(Event event) async {
    channel.sink.add({"route": "events:create", "value": event.toJson()});
    return channel.stream
        .firstWhere((event) => event['route'] == "events:create")
        .then((value) {
      var data = value as Map<String, dynamic>;
      if (data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
      return Event.fromJson(data);
    });
  }

  @override
  Future<void> deleteEvent(int id) {
    channel.sink.add({"route": "event:delete", "value": id});
    return channel.stream
        .firstWhere((event) => event['route'] == "event:delete")
        .then((value) {
      var data = value as Map<String, dynamic>;
      if (data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
    });
  }

  @override
  Future<List<Event>> fetchDoneEvents() {
    channel.sink.add({"route": "events:fetch-done"});
    return channel.stream
        .firstWhere((event) => event['route'] == "events:fetch-done")
        .then((value) {
      var data = value as Map<String, dynamic>;
      if (data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
      return (data['value'] as List<Map<String, dynamic>>)
          .map((e) => Event.fromJson(e))
          .toList();
    });
  }

  @override
  Future<Event?> fetchEvent(int id) {
    channel.sink.add({"route": "event:fetch", "value": id});
    return channel.stream
        .firstWhere((event) => event['route'] == "event:fetch")
        .then((value) {
      var data = value as Map<String, dynamic>;
      if (data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
      return data.containsKey("value") ? Event.fromJson(data["value"]) : null;
    });
  }

  @override
  Future<List<Event>> fetchEvents() {
    channel.sink.add({"route": "events:fetch"});
    return channel.stream
        .firstWhere((event) => event['route'] == "events:fetch")
        .then((value) {
      var data = value as Map<String, dynamic>;
      if (data.containsKey("exception")) {
        throw InputException.fromJson(data["exception"]);
      }
      return (data['value'] as List<Map<String, dynamic>>)
          .map((e) => Event.fromJson(e))
          .toList();
    });
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
