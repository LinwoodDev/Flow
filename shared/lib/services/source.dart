import 'dart:async';

import 'package:collection/collection.dart';
import 'package:shared/models/event/item/service.dart';
import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/cached.dart';
import '../models/event/item/model.dart';
import '../models/event/model.dart';
import '../models/note/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService? get event => null;
  CalendarItemService? get calendarItem => null;

  NoteService? get note => null;
  NoteConnector<Event>? get eventNote => null;
  NoteConnector<CalendarItem>? get calendarItemNote => null;
  PlaceService? get place => null;
  GroupService? get group => null;
  UserService? get user => null;

  List<ModelService> get models => <ModelService?>[
        event,
        calendarItem,
        note,
        eventNote,
        calendarItemNote,
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
    calendarItem?.clear();
    for (final current in data.items) {
      await calendarItem?.createCalendarItem(current);
    }
  }
}

abstract class ModelService {
  FutureOr<void> clear();

  bool get isEditable => true;
}
