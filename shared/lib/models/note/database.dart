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
  Future<void> connect(int connectId, int noteId) async {
    await db?.insert(tableName, {
      'noteId': noteId,
      connectedIdName: connectId,
    });
  }

  @override
  Future<void> disconnect(int connectId, int noteId) async {
    await db?.delete(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId, connectId],
    );
  }

  @override
  Future<List<Note>> getNotes(int connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      tableName,
      where: '$connectedIdName = ?',
      whereArgs: [connectId],
      offset: offset,
      limit: limit,
    );
    return result?.map(Note.fromJson).toList() ?? [];
  }

  @override
  Future<List<T>> getConnected(int noteId,
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
  Future<bool> isNoteConnected(int connectId, int noteId) async {
    final result = await db?.query(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId, connectId],
    );
    return result?.isNotEmpty == true;
  }

  @override
  Future<bool?> notesDone(int connectId) async {
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
    final id = await db?.insert('notes', note.toJson()..remove('id'));
    if (id == null) return null;
    return note.copyWith(id: id);
  }

  @override
  Future<bool> deleteNote(int id) async {
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
    int? parent,
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
      if (parent >= 0) {
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
                Note.fromJson(Map.from(row)..['done'] = row['done'] == 1))
            .toList() ??
        [];
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<bool> updateNote(Note note) async {
    return await db?.update(
          'notes',
          note.toJson()..remove('id'),
          where: 'id = ?',
          whereArgs: [note.id],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('notes');
  }
}
