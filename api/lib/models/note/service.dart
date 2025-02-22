import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class NoteService extends ModelService {
  FutureOr<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    Uint8List? parent,
    Uint8List? notebook,
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

  FutureOr<bool> deleteNote(Uint8List id);

  FutureOr<Note?> getNote(Uint8List id, {bool fallback = false});

  FutureOr<List<Notebook>> getNotebooks({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Notebook?> createNotebook(Notebook notebook);

  FutureOr<bool> updateNotebook(Notebook notebook);

  FutureOr<bool> deleteNotebook(Uint8List id);

  FutureOr<Notebook?> getNotebook(Uint8List id);
}

abstract class NoteConnector<T> extends ModelConnector<Note, T> {
  FutureOr<bool?> notesDone(Uint8List connectId);
}
