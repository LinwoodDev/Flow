import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class NoteService extends ModelService {
  FutureOr<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    int? parent,
    Set<NoteStatus?> statuses = const {
      NoteStatus.todo,
      NoteStatus.inProgress,
      NoteStatus.done,
      null,
    },
    String search = '',
  });

  FutureOr<Note?> createNote(Note note);

  FutureOr<bool> updateNote(Note note);

  FutureOr<bool> deleteNote(int id);
}

abstract class NoteConnector<T> extends ModelService {
  FutureOr<void> connect(int connectId, int noteId);
  FutureOr<void> disconnect(int connectId, int noteId);
  FutureOr<List<Note>> getNotes(
    int connectId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<T>> getConnected(
    int noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(int connectId, int noteId);
  FutureOr<bool?> notesDone(int connectId);
}
