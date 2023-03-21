import 'dart:async';

import '../../../services/source.dart';
import '../../event/model.dart';
import '../model.dart';

abstract class AppointmentNoteService extends ModelService {
  FutureOr<void> connect(int appointmentId, int noteId);
  FutureOr<void> disconnect(int appointmentId, int noteId);
  FutureOr<List<Note>> getNotes(
    int appointmentId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<Appointment>> getAppointments(
    int noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(int appointmentId, int noteId);
}
