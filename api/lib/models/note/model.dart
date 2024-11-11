import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';

import '../../helpers/converter.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Notebook with _$Notebook, IdentifiedModel, NamedModel, DescriptiveModel {
  const Notebook._();

  @Implements<DescriptiveModel>()
  const factory Notebook({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
  }) = _Notebook;

  factory Notebook.fromJson(Map<String, dynamic> json) =>
      _$NotebookFromJson(json);

  factory Notebook.fromDatabase(Map<String, dynamic> row) => Notebook.fromJson({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}

@freezed
class Note with _$Note, IdentifiedModel, NamedModel, DescriptiveModel {
  const Note._();

  @Implements<DescriptiveModel>()
  const factory Note({
    @Uint8ListConverter() Uint8List? notebookId,
    @Uint8ListConverter() Uint8List? id,
    @Uint8ListConverter() Uint8List? parentId,
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
  bool? get done => switch (this) {
        NoteStatus.todo => false,
        NoteStatus.inProgress => null,
        NoteStatus.done => true,
      };

  static NoteStatus fromDone(bool? done) => switch (done) {
        true => NoteStatus.done,
        false => NoteStatus.todo,
        null => NoteStatus.inProgress,
      };
}
