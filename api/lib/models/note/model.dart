import 'package:dart_mappable/dart_mappable.dart';
import 'dart:typed_data';

import '../model.dart';

part 'model.mapper.dart';

@MappableClass()
class Notebook
    with NotebookMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  const Notebook({
    this.id,
    this.name = '',
    this.description = '',
  });

  factory Notebook.fromDatabase(Map<String, dynamic> row) =>
      NotebookMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}

@MappableClass()
class Note with NoteMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  final Uint8List? notebookId, parentId;
  @override
  final String name, description;
  final NoteStatus? status;
  final int priority;

  const Note({
    this.notebookId,
    this.id,
    this.parentId,
    this.name = '',
    this.description = '',
    this.status,
    this.priority = 0,
  });

  factory Note.fromDatabase(Map<String, dynamic> row) => NoteMapper.fromMap({
        ...row,
      });

  Map<String, dynamic> toDatabase() => {
        ...toMap(),
      };
}

@MappableEnum()
enum NoteStatus {
  todo,
  inProgress,
  done;

  bool? get isDone => switch (this) {
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
