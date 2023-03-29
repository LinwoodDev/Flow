import 'dart:async';

import 'package:shared/services/source.dart';

import 'appointment/model.dart';
import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<Event?> getEvent(int id);
  FutureOr<Event?> getEventByAppointment(Appointment appointment) =>
      getEvent(appointment.eventId);

  FutureOr<List<Event>> getEvents({
    int? groupId,
    int? placeId,
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(int id);
}
