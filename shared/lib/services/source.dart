import 'dart:async';

import 'package:collection/collection.dart';
import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/cached.dart';
import '../models/event/appointment/model.dart';
import '../models/event/appointment/service.dart';
import '../models/event/model.dart';
import '../models/event/moment/model.dart';
import '../models/event/moment/service.dart';
import '../models/note/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService? get event => null;
  AppointmentService? get appointment => null;
  MomentService? get moment => null;

  NoteService? get note => null;
  NoteConnector<Event>? get eventNote => null;
  NoteConnector<Appointment>? get appointmentNote => null;
  NoteConnector<Moment>? get momentNote => null;
  PlaceService? get place => null;
  GroupService? get group => null;
  UserService? get user => null;

  List<ModelService> get models => <ModelService?>[
        event,
        appointment,
        moment,
        note,
        eventNote,
        appointmentNote,
        momentNote,
        group,
        user,
        place
      ].whereNotNull().toList();

  Future<void> import(CachedData data, [bool clear = true]) async {
    event?.clear();
    for (final current in data.events) {
      await event?.createEvent(current);
    }
    note?.clear();
    for (final current in data.notes) {
      await note?.createNote(current);
    }
    appointment?.clear();
    for (final current in data.appointments) {
      await appointment?.createAppointment(current);
    }
  }
}

abstract class ModelService {
  FutureOr<void> clear();

  bool get isEditable => true;
}
