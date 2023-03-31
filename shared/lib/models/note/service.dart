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

  FutureOr<bool?> notesDone(int eventId);

  FutureOr<Note?> createNote(Note note);

  FutureOr<bool> updateNote(Note note);

  FutureOr<bool> deleteNote(int id);
}
