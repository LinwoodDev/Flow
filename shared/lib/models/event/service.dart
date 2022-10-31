import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<List<Event>> getEvents({
    EventStatus? status,
  });

  FutureOr<Event?> createEvent({
    required String name,
    String description = '',
    required DateTime start,
    required DateTime end,
  });

  FutureOr<bool> updateEvent(Event event);
}

abstract class EventGroupService extends ModelService {
  FutureOr<List<EventGroup>> getGroups();
}
