import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class NoteService extends ModelService {
  FutureOr<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    String? parent,
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

  FutureOr<bool> deleteNote(String id);

  FutureOr<Note?> getNote(String id);
}

abstract class NoteConnector<T> extends ModelService {
  FutureOr<void> connect(String connectId, String noteId);
  FutureOr<void> disconnect(String connectId, String noteId);
  FutureOr<List<Note>> getNotes(
    String connectId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<T>> getConnected(
    String noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(String connectId, String noteId);
  FutureOr<bool?> notesDone(String connectId);
}
