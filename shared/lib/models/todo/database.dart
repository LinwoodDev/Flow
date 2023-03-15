import 'dart:async';

import 'package:shared/models/todo/service.dart';
import 'package:shared/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'model.dart';

class TodoDatabaseService extends TodoService with TableService {
  @override
  Future<void> create(Database db) {
    return db.execute("""
      CREATE TABLE IF NOT EXISTS todos (
        id INTEGER PRIMARY KEY,
        eventId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        status VARCHAR(20) NOT NULL DEFAULT 'todo',
        priority INTEGER NOT NULL DEFAULT 0,
        parentId INTEGER
      )
    """);
  }

  @override
  Future<Todo?> createTodo(Todo todo) async {
    final id = await db?.insert('todos', todo.toJson()..remove('id'));
    if (id == null) return null;
    return todo.copyWith(id: id);
  }

  @override
  Future<bool> deleteTodo(int id) async {
    return await db?.delete(
          'todos',
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
    Set<TodoStatus> statuses = const {
      TodoStatus.todo,
      TodoStatus.inProgress,
      TodoStatus.done
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
      'todos',
      where: where,
      whereArgs: whereArgs,
      offset: offset,
      limit: limit,
      orderBy: 'priority DESC',
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
        'SELECT COUNT(*) AS count FROM todos WHERE eventId = ? AND status = ?',
        [eventId, TodoStatus.done.name]);
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
          todo.toJson()..remove('id'),
          where: 'id = ?',
          whereArgs: [todo.id],
        ) ==
        1;
  }

  @override
  Future<void> clear() async {
    await db?.delete('todos');
  }
}
