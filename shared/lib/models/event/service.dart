import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<List<Event>> getEvents({
    EventStatus? status,
  });
}

abstract class EventGroupService extends ModelService {
  FutureOr<List<EventGroup>> getGroups();
}
