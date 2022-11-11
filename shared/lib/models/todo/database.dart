import 'dart:async';

import 'package:shared/models/todo/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';

class TodoDatabaseService extends TodoService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS Todos (
        id INTEGER PRIMARY KEY,
        eventId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        done INTEGER NOT NULL DEFAULT 0,
        parentID INTEGER
      )
    """);
  }

  @override
  Future<Todo?> createTodo(Todo todo) async {
    final id = await db?.insert(
        'Todos',
        todo.toJson()
          ..remove('id')
          ..['done'] = todo.done ? 1 : 0);
    if (id == null) return null;
    return todo.copyWith(id: id);
  }

  @override
  Future<bool> deleteTodo(int id) async {
    return await db?.delete(
          'Todos',
          where: 'id = ?',
          whereArgs: [id],
        ) ==
        1;
  }

  @override
  Future<List<Todo>> getTodos({
    int? eventId,
    int offset = 0,
    int limit = 50,
    bool incomplete = true,
    bool completed = true,
  }) async {
    var where = '';
    final whereArgs = <Object?>[];
    if (eventId != null) {
      where += 'eventId = ?';
      whereArgs.add(eventId);
    }
    if (incomplete && !completed) {
      if (where.isNotEmpty) where += ' AND ';
      where += 'done = 0';
    } else if (!incomplete && completed) {
      if (where.isNotEmpty) where += ' AND ';
      where += 'done = 1';
    } else if (!incomplete && !completed) {
      return [];
    }
    final result = await db?.query(
      'todos',
      where: where == '' ? null : where,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      offset: offset,
      limit: limit,
    );
    return result
            ?.map((row) =>
                Todo.fromJson(Map.from(row)..['done'] = row['done'] == 1))
            .toList() ??
        [];
  }

  @override
  Future<bool?> todosDone(int eventId) async {
    final result = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM todos WHERE eventId = ? AND done = 1',
        [eventId]);
    final resultCount = result?.first['count'] as int? ?? 0;
    final all = await db?.rawQuery(
        'SELECT COUNT(*) AS count FROM todos WHERE eventId = ?', [eventId]);
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
  FutureOr<bool> updateTodo(Todo todo) async {
    return await db?.update(
          'todos',
          todo.toJson()
            ..remove('id')
            ..['done'] = todo.done ? 1 : 0,
          where: 'id = ?',
          whereArgs: [todo.id],
        ) ==
        1;
  }
}
