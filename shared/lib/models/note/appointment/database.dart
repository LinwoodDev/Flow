import 'package:shared/models/event/appointment/model.dart';

import 'package:shared/models/note/database.dart';

class AppointmentNoteDatabaseConnector
    extends NoteDatabaseConnector<Appointment> {
  @override
  String get connectedIdName => "appointmentId";

  @override
  String get connectedTableName => "appointments";

  @override
  String get tableName => "appointmentNotes";
}
