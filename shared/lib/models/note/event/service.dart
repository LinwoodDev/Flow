import 'dart:async';

import '../../../services/source.dart';
import '../../event/model.dart';
import '../model.dart';

abstract class EventNoteService extends ModelService {
  FutureOr<void> connect(int eventId, int noteId);
  FutureOr<void> disconnect(int eventId, int noteId);
  FutureOr<List<Note>> getNotes(
    int eventId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<Event>> getEvents(
    int noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(int eventId, int noteId);
}
