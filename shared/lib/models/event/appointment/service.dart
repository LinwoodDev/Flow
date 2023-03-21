import 'dart:async';

import '../../../services/source.dart';
import '../model.dart';
import 'model.dart';

abstract class AppointmentService extends ModelService {
  FutureOr<Appointment?> getAppointment(int id);
  FutureOr<List<Appointment>> getAppointments({
    List<EventStatus>? status,
    int? eventId,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  });

  FutureOr<Appointment?> createAppointment(Appointment appointment);

  FutureOr<bool> updateAppointment(Appointment appointment);

  FutureOr<bool> deleteAppointment(int id);
}

abstract class AppointmentEventConnector {
  FutureOr<List<Appointment>> getAppointments({
    List<EventStatus>? status,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
    int? groupId,
    int? placeId,
  });
}
