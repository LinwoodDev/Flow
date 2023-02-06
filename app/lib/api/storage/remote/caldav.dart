import 'package:shared/models/event/model.dart';
import 'dart:async';

import 'package:shared/models/user/service.dart';
import 'package:shared/models/todo/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/event/service.dart';

import 'service.dart';

class CalDavRemoteService extends RemoteService {
  CalDavRemoteService(super.baseUrl);

  @override
  // TODO: implement event
  EventService get event => throw UnimplementedError();

  @override
  // TODO: implement group
  GroupService get group => throw UnimplementedError();

  @override
  // TODO: implement place
  PlaceService get place => throw UnimplementedError();

  @override
  // TODO: implement todo
  TodoService get todo => throw UnimplementedError();

  @override
  // TODO: implement user
  UserService get user => throw UnimplementedError();

  @override
  // TODO: implement version
  String get version => throw UnimplementedError();
}

class CalDavEventService extends EventService {
  final String baseUrl;

  CalDavEventService(this.baseUrl);

  @override
  FutureOr<Event?> createEvent(Event event) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> deleteEvent(int id) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  FutureOr<Event?> getEvent(int id) {
    // TODO: implement getEvent
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

  @override
  FutureOr<List<Event>> getEvents(
      {bool pending = false,
      List<EventStatus>? status,
      int? groupId,
      int? placeId,
      int offset = 0,
      int limit = 50,
      DateTime? start,
      DateTime? end,
      DateTime? date,
      String search = ''}) {
    // TODO: implement getEvents
    throw UnimplementedError();
  }
}
