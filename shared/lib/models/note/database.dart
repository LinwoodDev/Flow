import 'dart:async';

import 'package:collection/collection.dart';
import 'package:lib5/lib5.dart';
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
        noteId BLOB(16) NOT NULL,
        $connectedIdName BLOB(16) NOT NULL,
        PRIMARY KEY ($connectedIdName, noteId),
        FOREIGN KEY ($connectedIdName) REFERENCES $connectedTableName(id) ON DELETE CASCADE,
        FOREIGN KEY (noteId) REFERENCES notes(id) ON DELETE CASCADE
      )
    """);
  }

  @override
  Future<void> connect(Multihash connectId, Multihash noteId) async {
    await db?.insert(tableName, {
      'noteId': noteId.fullBytes,
      connectedIdName: connectId.fullBytes,
    });
  }

  @override
  Future<void> disconnect(Multihash connectId, Multihash noteId) async {
    await db?.delete(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId.fullBytes, connectId.fullBytes],
    );
  }

  @override
  Future<List<Note>> getNotes(Multihash connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN notes ON notes.id = noteId',
      where: '$connectedIdName = ?',
      whereArgs: [connectId.fullBytes],
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
  Future<List<T>> getConnected(Multihash noteId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      tableName,
      where: 'noteId = ?',
      whereArgs: [noteId.fullBytes],
      offset: offset,
      limit: limit,
    );
    return result?.map(_decode).toList() ?? [];
  }

  @override
  Future<bool> isNoteConnected(Multihash connectId, Multihash noteId) async {
    final result = await db?.query(
      tableName,
      where: 'noteId = ? AND $connectedIdName = ?',
      whereArgs: [noteId.fullBytes, connectId.fullBytes],
    );
    return result?.isNotEmpty == true;
  }

  @override
  Future<bool?> notesDone(Multihash connectId) async {
    final result = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE $connectedIdName = ? AND status = ?',
        [connectId.fullBytes, NoteStatus.done.name]);
    final resultCount = result?.first['count'] as int? ?? 0;
    final all = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE $connectedIdName = ?',
        [connectId.fullBytes]);
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
        id BLOB(16) PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        status VARCHAR(20),
        priority INTEGER NOT NULL DEFAULT 0,
        parentId BLOB(16)
      )
    """);
  }

  @override
  Future<Note?> createNote(Note note) async {
    final id = note.id ?? createUniqueMultihash();
    note = note.copyWith(id: id);
    final row = await db?.insert('notes', note.toDatabase());
    if (row == null) return null;
    return note;
  }

  @override
  Future<bool> deleteNote(Multihash id) async {
    return await db?.delete(
          'notes',
          where: 'id = ?',
          whereArgs: [id.fullBytes],
        ) ==
        1;
  }

  @override
  Future<List<Note>> getNotes({
    int offset = 0,
    int limit = 50,
    Multihash? parent,
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
      if (parent.fullBytes.isNotEmpty) {
        where = where == null ? 'parentId = ?' : '$where AND parentId = ?';
        whereArgs = whereArgs == null
            ? [parent.fullBytes]
            : [...whereArgs, parent.fullBytes];
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
    return result?.map((row) => Note.fromDatabase(row)).toList() ?? [];
  }

  @override
  FutureOr<void> migrate(Database db, int version) {}

  @override
  FutureOr<bool> updateNote(Note note) async {
    return await db?.update(
          'notes',
          note.toDatabase()..remove('id'),
          where: 'id = ?',
          whereArgs: [note.id?.fullBytes],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('notes');
  }

  @override
  Future<Note?> getNote(Multihash id) async {
    final result = await db?.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id.fullBytes],
    );
    return result?.map(Note.fromDatabase).firstOrNull;
  }
}
