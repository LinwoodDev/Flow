import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/cached.dart';
import '../models/note/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService? get event => null;
  NoteService? get note => null;
  PlaceService? get place => null;
  GroupService? get group => null;
  UserService? get user => null;

  List<ModelService> get models =>
      [event, note, group, user, place].whereType<ModelService>().toList();

  Future<void> import(CachedData data, [bool clear = true]) async {
    event?.clear();
    for (final current in data.events) {
      await event?.createEvent(current);
    }
    note?.clear();
    for (final current in data.notes) {
      await note?.createNote(current);
    }
  }
}

abstract class ModelService {
  Future<void> clear();

  bool get isEditable => true;
}
