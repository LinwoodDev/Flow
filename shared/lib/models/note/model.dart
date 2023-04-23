import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Note with _$Note {
  const Note._();

  @Implements<DescriptiveModel>()
  const factory Note({
    String? id,
    String? parentId,
    @Default('') String name,
    @Default('') String description,
    NoteStatus? status,
    @Default(0) int priority,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.fromDatabase(Map<String, dynamic> row) => Note.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
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
