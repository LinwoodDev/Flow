import 'dart:async';

import 'package:collection/collection.dart';
import 'package:lib5/lib5.dart';
import 'package:flow_api/models/label/model.dart';

import 'package:flow_api/models/note/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';
import 'service.dart';

abstract class LabelNoteConnector extends NoteConnector<Label> {
  @override
  Future<List<Note>> getNotes(
    Multihash connectId, {
    int offset = 0,
    int limit = 50,
    Multihash? parent,
    Multihash? notebook,
    Set<NoteStatus?> statuses = const {
      NoteStatus.todo,
      NoteStatus.inProgress,
      NoteStatus.done,
      null
    },
    String search = '',
  });
}

class LabelNoteDatabaseConnector extends NoteDatabaseConnector<Label>
    implements LabelNoteConnector {
  @override
  String get connectedIdName => "labelId";

  @override
  String get connectedTableName => "labels";

  @override
  String get tableName => "labelNotes";

  @override
  Future<List<Note>> getNotes(
    Multihash connectId, {
    int offset = 0,
    int limit = 50,
    Multihash? parent,
    Multihash? notebook,
    Set<NoteStatus?> statuses = const {
      NoteStatus.todo,
      NoteStatus.inProgress,
      NoteStatus.done,
      null
    },
    String search = '',
  }) async {
    String? where;
    List<Object> whereArgs = [];
    if (search.isNotEmpty) {
      where = '(name LIKE ? OR description LIKE ?)';
      whereArgs = ['%$search%', '%$search%'];
    }
    if (parent != null) {
      if (parent.fullBytes.isNotEmpty) {
        where = where == null ? 'parentId = ?' : '$where AND parentId = ?';
        whereArgs.add(parent.fullBytes);
      } else {
        where =
            where == null ? 'parentId IS NULL' : '$where AND parentId IS NULL';
      }
    }
    if (notebook != null) {
      if (notebook.fullBytes.isNotEmpty) {
        where = where == null ? 'notebookId = ?' : '$where AND notebookId = ?';
        whereArgs.add(notebook.fullBytes);
      } else {
        where = where == null
            ? 'notebookId IS NULL'
            : '$where AND notebookId IS NULL';
      }
    }
    var statusStatement =
        "status IN (${statuses.whereNotNull().map((e) => "'${e.name}'").join(',')})";
    if (statuses.contains(null)) {
      statusStatement = "$statusStatement OR status IS NULL";
    }
    where =
        where == null ? '($statusStatement)' : '$where AND ($statusStatement)';
    final result = await db?.query(
      '$tableName JOIN notes ON notes.id = noteId',
      where: '$where AND $connectedIdName = ?',
      whereArgs: [...whereArgs, connectId.fullBytes],
      columns: [
        'notes.id AS noteid',
        'notes.name AS notename',
        'notes.description AS notedescription',
        'notes.status AS notestatus',
        'notes.priority AS notepriority',
        'notes.parentId AS noteparentId',
      ],
      offset: offset,
      limit: limit,
    );
    return result
            ?.map((e) => Map.fromEntries(e.entries
                .where((element) => element.key.startsWith('note'))
                .map((e) => MapEntry(e.key.substring('note'.length), e.value))))
            .map((e) {
          return Note.fromDatabase(e);
        }).toList() ??
        [];
  }

  @override
  FutureOr<void> migrate(Database db, int version) async {
    if (version < 2) {
      await create(db);
    }
    return super.migrate(db, version);
  }

  @override
  Label decode(Map<String, dynamic> data) => Label.fromDatabase(data);
}
