import 'dart:async';

import 'package:shared/models/note/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';

class NoteDatabaseService extends NoteService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS notes (
        id INTEGER PRIMARY KEY,
        eventId INTEGER,
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
    int? eventId,
    int offset = 0,
    int limit = 50,
    Set<NoteStatus> statuses = const {
      NoteStatus.note,
      NoteStatus.inProgress,
      NoteStatus.done
    },
    String search = '',
  }) async {
    String? where;
    List<Object>? whereArgs;
    if (eventId != null) {
      where = 'eventId = ?';
      whereArgs = [eventId];
    }
    if (search.isNotEmpty) {
      where = where == null
          ? '(name LIKE ? OR description LIKE ?)'
          : '$where AND (name LIKE ? OR description LIKE ?)';
      whereArgs = whereArgs == null
          ? ['%$search%', '%$search%']
          : [...whereArgs, '%$search%', '%$search%'];
    }
    final statusStatement =
        "status IN (${statuses.map((e) => "'${e.name}'").join(',')})";
    if (where != null) {
      where += ' AND $statusStatement';
    } else {
      where = statusStatement;
    }
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
  Future<bool?> notesDone(int eventId) async {
    final result = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE eventId = ? AND status = ?',
        [eventId, NoteStatus.done.name]);
    final resultCount = result?.first['count'] as int? ?? 0;
    final all = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM notes WHERE eventId = ?', [eventId]);
    final allCount = all?.first['count'] as int? ?? 0;
    if (resultCount == allCount && allCount > 0) {
      return true;
    }
    if (resultCount == 0 && allCount > 0) {
      return false;
    }
    return null;
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
