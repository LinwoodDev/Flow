import 'dart:async';

import 'package:shared/services/source.dart';

import 'appointment/model.dart';
import 'model.dart';

abstract class MomentService extends ModelService {
  FutureOr<Moment?> getMoment(int id);
  FutureOr<List<Moment>> getMoments({
    bool pending = false,
    List<EventStatus>? status,
    int? groupId,
    int? placeId,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  });

  FutureOr<Moment?> createMoment(Moment moment);

  FutureOr<bool> updateMoment(Moment moment);

  FutureOr<bool> deleteMoment(int id);
}

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
