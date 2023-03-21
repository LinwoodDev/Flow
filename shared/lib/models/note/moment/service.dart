import 'dart:async';

import '../../../services/source.dart';
import '../../event/model.dart';
import '../model.dart';

abstract class MomentNoteService extends ModelService {
  FutureOr<void> connect(int momentId, int noteId);
  FutureOr<void> disconnect(int momentId, int noteId);
  FutureOr<List<Note>> getNotes(
    int momentId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<List<Moment>> getMoments(
    int noteId, {
    int offset = 0,
    int limit = 50,
  });
  FutureOr<bool> isNoteConnected(int momentId, int noteId);
}
