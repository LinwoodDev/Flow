import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/services/source.dart';

import 'model.dart';

abstract class NoteService extends ModelService {
  FutureOr<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    Multihash? parent,
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

  FutureOr<bool> deleteNote(Multihash id);

  FutureOr<Note?> getNote(Multihash id);
}

abstract class NoteConnector<T> extends ModelService {
  FutureOr<void> connect(Multihash connectId, Multihash noteId);
  FutureOr<void> disconnect(Multihash connectId, Multihash noteId);
  FutureOr<List<Note>> getNotes(
    Multihash connectId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<T>> getConnected(
    Multihash noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(Multihash connectId, Multihash noteId);
  FutureOr<bool?> notesDone(Multihash connectId);
}
