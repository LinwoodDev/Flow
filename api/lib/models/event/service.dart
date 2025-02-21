import 'dart:async';
import 'dart:typed_data';

import 'package:flow_api/services/source.dart';

import 'item/model.dart';
import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<Event?> getEvent(Uint8List id);
  FutureOr<Event?> getEventByItem(CalendarItem item) =>
      item.eventId == null ? null : getEvent(item.eventId!);

  FutureOr<List<Event>> getEvents({
    Uint8List? groupId,
    int offset = 0,
    int limit = 50,
    String search = '',
    List<Uint8List>? resourceIds,
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(Uint8List id);
}
