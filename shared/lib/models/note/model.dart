import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Note with _$Note {
  @Implements<DescriptiveModel>()
  const factory Note({
    int? id,
    int? parentId,
    @Default('') String name,
    @Default('') String description,
    NoteStatus? status,
    @Default(0) int priority,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}

enum NoteStatus {
  todo,
  inProgress,
  done,
}

extension NoteStatusExtension on NoteStatus {
  bool? get done {
    switch (this) {
      case NoteStatus.todo:
        return false;
      case NoteStatus.inProgress:
        return null;
      case NoteStatus.done:
        return true;
    }
  }

  static NoteStatus fromDone(bool? done) {
    if (done == null) return NoteStatus.inProgress;
    if (done) return NoteStatus.done;
    return NoteStatus.todo;
  }
}
