import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<List<Event>> getEvents({
    EventStatus? status,
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(Event event);
}

abstract class EventGroupService extends ModelService {
  FutureOr<List<EventGroup>> getGroups();
}
