import 'dart:async';

import '../../../services/source.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';

abstract class AppointmentService extends ModelService {
  FutureOr<Appointment?> getAppointment(int id);
  FutureOr<List<ConnectedModel<Appointment, Event?>>> getAppointments({
    List<EventStatus>? status,
    int? eventId,
    int? groupId,
    int? placeId,
    bool pending = false,
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
