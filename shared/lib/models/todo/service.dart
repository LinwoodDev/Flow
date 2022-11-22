import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class TodoService extends ModelService {
  FutureOr<List<Todo>> getTodos({
    int? eventId,
    int offset = 0,
    int limit = 50,
    Set<TodoStatus> statuses = const {TodoStatus.todo, TodoStatus.done},
  });

  FutureOr<bool?> todosDone(int eventId);

  FutureOr<Todo?> createTodo(Todo todo);

  FutureOr<bool> updateTodo(Todo todo);

  FutureOr<bool> deleteTodo(int id);
}
