import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<Event?> getEvent(int id);
  FutureOr<List<Event>> getEvents({
    List<EventStatus> status,
    int? groupId,
    int? placeId,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(int id);
}

abstract class EventGroupService extends ModelService {
  FutureOr<EventGroup?> getGroup(int id);

  FutureOr<List<EventGroup>> getGroups({
    String search = '',
    int limit = 50,
    int offset = 0,
  });

  FutureOr<EventGroup?> createGroup(EventGroup group);

  FutureOr<bool> updateGroup(EventGroup group);

  FutureOr<bool> deleteGroup(int id);
}
