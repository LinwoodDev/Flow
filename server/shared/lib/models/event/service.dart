import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/services/source.dart';

import 'item/model.dart';
import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<Event?> getEvent(Multihash id);
  FutureOr<Event?> getEventByItem(CalendarItem item) =>
      item.eventId == null ? null : getEvent(item.eventId!);

  FutureOr<List<Event>> getEvents({
    Multihash? groupId,
    Multihash? placeId,
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(Multihash id);
}
