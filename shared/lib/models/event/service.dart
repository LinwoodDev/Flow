import 'dart:async';

import 'model.dart';

abstract class EventService {
  FutureOr<List<Event>> getEvents({
    EventStatus? status,
  });
}

abstract class EventGroupService {
  FutureOr<List<EventGroup>> getGroups();
}
