import 'dart:async';
import 'dart:typed_data';

import 'package:flow_api/models/event/item/service.dart';
import 'package:flow_api/models/event/service.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/group/service.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/label/service.dart';
import 'package:flow_api/models/note/label.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/resource/service.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/models/user/service.dart';

import '../models/cached.dart';
import '../models/event/item/model.dart';
import '../models/event/model.dart';
import '../models/note/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService? get event => null;
  CalendarItemService? get calendarItem => null;

  NoteService? get note => null;
  LabelNoteConnector? get labelNote => null;
  NoteConnector<Event>? get eventNote => null;
  NoteConnector<CalendarItem>? get calendarItemNote => null;
  NoteConnector<User>? get userNote => null;
  NoteConnector<Group>? get groupNote => null;
  ResourceService? get resource => null;
  ResourceConnector<Event>? get eventResource => null;
  ResourceConnector<CalendarItem>? get calendarItemResource => null;
  ResourceConnector<User>? get userResource => null;
  ResourceConnector<Group>? get groupResource => null;
  GroupService? get group => null;
  UserService? get user => null;
  LabelService? get label => null;
  ModelConnector<User, Event>? get eventUser => null;
  ModelConnector<Group, User>? get userGroup => null;
  ModelConnector<Group, Event>? get eventGroup => null;
  ModelConnector<User, CalendarItem>? get calendarItemUser => null;
  ModelConnector<Group, CalendarItem>? get calendarItemGroup => null;
  ModelConnector<Notebook, User>? get userNotebook => null;
  ModelConnector<Notebook, Group>? get groupNotebook => null;
  ModelConnector<Label, User>? get userLabel => null;
  ModelConnector<Label, Group>? get groupLabel => null;

  List<ModelService> get models => <ModelService?>[
        event,
        calendarItem,
        note,
        labelNote,
        eventNote,
        userNote,
        groupNote,
        calendarItemNote,
        group,
        user,
        resource,
        eventResource,
        calendarItemResource,
        userResource,
        groupResource,
        label,
        eventUser,
        userGroup,
        eventGroup,
        calendarItemUser,
        calendarItemGroup,
        userNotebook,
        groupNotebook,
        userLabel,
        groupLabel,
      ].nonNulls.toList();

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

abstract class ModelConnector<I, C> extends ModelService {
  FutureOr<void> connect(Uint8List connectId, Uint8List itemId);
  FutureOr<void> disconnect(Uint8List connectId, Uint8List itemId);
  FutureOr<bool> isConnected(Uint8List connectId, Uint8List itemId);
  Future<List<I>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50});

  Future<List<C>> getConnected(Uint8List itemId,
      {int offset = 0, int limit = 50});
}

class ReversedModelConnector<I, C> extends ModelConnector<I, C> {
  final ModelConnector<C, I> connector;

  ReversedModelConnector(this.connector);

  @override
  FutureOr<void> connect(Uint8List connectId, Uint8List itemId) =>
      connector.connect(itemId, connectId);

  @override
  FutureOr<void> disconnect(Uint8List connectId, Uint8List itemId) =>
      connector.disconnect(itemId, connectId);

  @override
  FutureOr<bool> isConnected(Uint8List connectId, Uint8List itemId) =>
      connector.isConnected(itemId, connectId);

  @override
  Future<List<I>> getItems(Uint8List connectId,
          {int offset = 0, int limit = 50}) =>
      connector.getConnected(connectId, offset: offset, limit: limit);

  @override
  Future<List<C>> getConnected(Uint8List itemId,
          {int offset = 0, int limit = 50}) =>
      connector.getItems(itemId, offset: offset, limit: limit);

  @override
  FutureOr<void> clear() => connector.clear();

  @override
  bool get isEditable => connector.isEditable;
}
