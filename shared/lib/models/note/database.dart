import 'dart:async';

import 'package:collection/collection.dart';
import 'package:shared/models/note/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';

abstract class NoteDatabaseConnector<T> extends NoteConnector<T>
    with TableService {
  String get tableName;
  String get connectedTableName;
  String get connectedIdName;

  T _decode(Map<String, dynamic> data);

  @override
  Future<void> create(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
        noteId INTEGER NOT NULL,
        $connectedIdName INTEGER NOT NULL,
        PRIMARY KEY ($connectedIdName, noteId),
        FOREIGN KEY ($connectedIdName) REFERENCES $connectedTableName(id) ON DELETE CASCADE,
        FOREIGN KEY (noteId) REFERENCES notes(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<void> connect(String connectId, String noteId) async {
    await db?.insert(tableName, {
      'noteId': noteId,
      connectedIdName: connectId,
    });
  }

  @override
  Future<void> disconnect(String connectId, String noteId) async {
    await db?.delete(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId, connectId],
    );
  }

  @override
  Future<List<Note>> getNotes(String connectId,
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
  Future<List<T>> getConnected(String noteId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      tableName,
      where: 'noteId = ?',
      whereArgs: [noteId],
      offset: offset,
      limit: limit,
    );
    return result?.map(_decode).toList() ?? [];
  }

  @override
  Future<bool> isNoteConnected(String connectId, String noteId) async {
    final result = await db?.query(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId, connectId],
    );
    return result?.isNotEmpty == true;
  }

  @override
  Future<bool?> notesDone(String connectId) async {
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
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS notes (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        status VARCHAR(20),
        priority INTEGER NOT NULL DEFAULT 0,
        parentId INTEGER
      )
    """);
  }

  @override
  Future<Note?> createNote(Note note) async {
    final id = await db?.insert('notes', note.toDatabase()..remove('id'));
    if (id == null) return null;
    return note.copyWith(id: id.toString());
  }

  @override
  Future<bool> deleteNote(String id) async {
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
    String? parent,
    Set<NoteStatus?> statuses = const {
      NoteStatus.todo,
      NoteStatus.inProgress,
      NoteStatus.done,
      null
    },
    String search = '',
  }) async {
    String? where;
    List<Object>? whereArgs;
    if (search.isNotEmpty) {
      where = where == null
          ? '(name LIKE ? OR description LIKE ?)'
          : '$where AND (name LIKE ? OR description LIKE ?)';
      whereArgs = whereArgs == null
          ? ['%$search%', '%$search%']
          : [...whereArgs, '%$search%', '%$search%'];
    }
    if (parent != null) {
      if (parent.isNotEmpty) {
        where = where == null ? 'parentId = ?' : '$where AND parentId = ?';
        whereArgs = whereArgs == null ? [parent] : [...whereArgs, parent];
      } else {
        where =
            where == null ? 'parentId IS NULL' : '$where AND parentId IS NULL';
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
      'notes',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
      orderBy: 'priority DESC',
    );
    return result
            ?.map((row) =>
                Note.fromDatabase(Map.from(row)..['done'] = row['done'] == 1))
            .toList() ??
        [];
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

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
  Future<Note?> getNote(String id) async {
    final result = await db?.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result?.map(Note.fromDatabase).firstOrNull;
  }
}
