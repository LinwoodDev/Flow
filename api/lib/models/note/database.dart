import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/note/label.dart';
import 'dart:typed_data';
import 'package:flow_api/models/note/service.dart';
import 'package:flow_api/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';

abstract class NoteDatabaseConnector<T> extends DatabaseModelConnector<Note, T>
    implements NoteConnector<T> {
  @override
  String get itemIdName => 'noteId';
  @override
  String get itemTableName => 'notes';

  T decode(Map<String, dynamic> data);

  @override
  Future<List<Note>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN notes ON notes.id = noteId',
      where: '$connectedIdName = ?',
      whereArgs: [connectId],
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
  Future<List<T>> getConnected(Uint8List noteId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN $connectedTableName ON $connectedTableName.id = $connectedIdName',
      where: 'noteId = ?',
      whereArgs: [noteId],
      offset: offset,
      limit: limit,
    );
    return result?.map(decode).toList() ?? [];
  }

  @override
  Future<bool?> notesDone(Uint8List connectId) async {
    final result = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE $connectedIdName = ? AND status = ?',
        [connectId, NoteStatus.done.name]);
    final resultCount = result?.first['count'] as int? ?? 0;
    final all = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE $connectedIdName = ?',
        [connectId]);
    final allCount = all?.first['count'] as int? ?? 0;
    if (resultCount == allCount && allCount > 0) {
      return true;
    }
    if (resultCount == 0 && allCount > 0) {
      return false;
    }
    return null;
  }
}

class NoteDatabaseService extends NoteService with TableService {
  Future<void> createNotebookDatabase(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS notebooks (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT
      )
    """);
  }

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS notes (
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        status VARCHAR(20),
        priority INTEGER NOT NULL DEFAULT 0,
        notebookId BLOB(16),
        parentId BLOB(16)
      )
    """);
    await createNotebookDatabase(db);
  }

  @override
  Future<Note?> createNote(Note note) async {
    final id = note.id ?? createUniqueUint8List();
    note = note.copyWith(id: id);
    final row = await db?.insert('notes', note.toDatabase());
    if (row == null) return null;
    return note;
  }

  @override
  Future<bool> deleteNote(Uint8List id) async {
    return await db?.delete(
          'notes',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    Uint8List? parent,
    Uint8List? notebook,
    Set<Uint8List> labels = const {},
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
      where = '(notes.name LIKE ? OR notes.description LIKE ?)';
      whereArgs = ['%$search%', '%$search%'];
    }
    if (parent != null) {
      if (parent.isNotEmpty) {
        where = where == null
            ? 'notes.parentId = ?'
            : '$where AND notes.parentId = ?';
        whereArgs.add(parent);
      } else {
        where = where == null
            ? 'notes.parentId IS NULL'
            : '$where AND notes.parentId IS NULL';
      }
    }
    if (notebook != null) {
      if (notebook.isNotEmpty) {
        where = where == null
            ? 'notes.notebookId = ?'
            : '$where AND notes.notebookId = ?';
        whereArgs.add(notebook);
      } else {
        where = where == null
            ? 'notes.notebookId IS NULL'
            : '$where AND notes.notebookId IS NULL';
      }
    }
    if (labels.isNotEmpty) {
      final labelPlaceholders = labels.map((_) => '?').join(',');
      where = where == null
          ? 'notes.id IN (SELECT noteId FROM labelNotes WHERE labelId IN ($labelPlaceholders))'
          : '$where AND notes.id IN (SELECT noteId FROM labelNotes WHERE labelId IN ($labelPlaceholders))';
      whereArgs.addAll(labels);
    }
    var statusStatement =
        "notes.status IN (${statuses.nonNulls.map((e) => "'${e.name}'").join(',')})";
    if (statuses.contains(null)) {
      statusStatement = "$statusStatement OR notes.status IS NULL";
    }
    where =
        where == null ? '($statusStatement)' : '$where AND ($statusStatement)';
    final result = await db?.query(
      'notes',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
      orderBy: 'notes.priority DESC',
    );
    return result?.map((row) => Note.fromDatabase(row)).toList() ?? [];
  }

  @override
  FutureOr<bool> updateNote(Note note) async {
    return await db?.update(
          'notes',
          note.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [note.id],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('notes');
  }

  @override
  Future<Note?> getNote(Uint8List id, {bool fallback = false}) async {
    final result = fallback
        ? await db?.rawQuery(
            """SELECT * FROM notes
WHERE slug = ? OR slug = (SELECT MIN(slug) FROM notes)
ORDER BY slug DESC
LIMIT 1;""",
            [id],
          )
        : await db?.query(
            'notes',
            where: 'id = ?',
            whereArgs: [id],
          );
    return result?.map(Note.fromDatabase).firstOrNull;
  }

  @override
  Future<Notebook?> createNotebook(Notebook notebook) async {
    final id = notebook.id ?? createUniqueUint8List();
    notebook = notebook.copyWith(id: id);
    final row = await db?.insert('notebooks', notebook.toDatabase());
    if (row == null) return null;
    return notebook;
  }

  @override
  Future<bool> deleteNotebook(Uint8List id) async {
    return await db?.delete(
          'notebooks',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<Notebook?> getNotebook(Uint8List id) async {
    final result = await db?.query(
      'notebooks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Notebook.fromDatabase).firstOrNull;
  }

  @override
  Future<List<Notebook>> getNotebooks(
      {int offset = 0, int limit = 50, String search = ''}) async {
    final result = await db?.query(
      'notebooks',
      where: 'name LIKE ?',
      whereArgs: ['%$search%'],
      offset: offset,
      limit: limit,
    );
    return result?.map(Notebook.fromDatabase).toList() ?? [];
  }

  @override
  Future<bool> updateNotebook(Notebook notebook) async {
    return await db?.update(
          'notebooks',
          notebook.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [notebook.id],
        ) ==
        1;
  }
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
  }) async {
    String? where;
    List<Object> whereArgs = [];
    if (search.isNotEmpty) {
      where = '(name LIKE ? OR description LIKE ?)';
      whereArgs = ['%$search%', '%$search%'];
    }
    if (parent != null) {
      if (parent.isNotEmpty) {
        where = where == null ? 'parentId = ?' : '$where AND parentId = ?';
        whereArgs.add(parent);
      } else {
        where =
            where == null ? 'parentId IS NULL' : '$where AND parentId IS NULL';
      }
    }
    if (notebook != null) {
      if (notebook.isNotEmpty) {
        where = where == null ? 'notebookId = ?' : '$where AND notebookId = ?';
        whereArgs.add(notebook);
      } else {
        where = where == null
            ? 'notebookId IS NULL'
            : '$where AND notebookId IS NULL';
      }
    }
    var statusStatement =
        "status IN (${statuses.nonNulls.map((e) => "'${e.name}'").join(',')})";
    if (statuses.contains(null)) {
      statusStatement = "$statusStatement OR status IS NULL";
    }
    where =
        where == null ? '($statusStatement)' : '$where AND ($statusStatement)';
    final result = await db?.query(
      '$tableName JOIN notes ON notes.id = noteId',
      where: '$where AND $connectedIdName = ?',
      whereArgs: [...whereArgs, connectId],
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
  Label decode(Map<String, dynamic> data) => Label.fromDatabase(data);
}
