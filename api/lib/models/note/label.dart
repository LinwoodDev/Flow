import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/models/label/model.dart';

import 'model.dart';
import 'service.dart';

abstract class LabelNoteConnector extends NoteConnector<Label> {
  @override
  Future<List<Note>> getItems(
    Uint8List connectId, {
    int offset = 0,
    int limit = 50,
    Uint8List? parent,
    Uint8List? notebook,
    Set<NoteStatus?> statuses = const {
      NoteStatus.todo,
      NoteStatus.inProgress,
      NoteStatus.done,
      null
    },
    String search = '',
  });
}
