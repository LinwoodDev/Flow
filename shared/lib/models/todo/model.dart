import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default(-1) int id,
    int? parentId,
    @Default('') String name,
    @Default('') String description,
    @Default(TodoStatus.todo) TodoStatus status,
    @Default(0) int priority,
    int? eventId,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

enum TodoStatus {
  todo,
  inProgress,
  done,
}

extension TodoStatusExtension on TodoStatus {
  bool? get done {
    switch (this) {
      case TodoStatus.todo:
        return false;
      case TodoStatus.inProgress:
        return null;
      case TodoStatus.done:
        return true;
    }
  }

  static TodoStatus fromDone(bool? done) {
    if (done == null) return TodoStatus.inProgress;
    if (done) return TodoStatus.done;
    return TodoStatus.todo;
  }
}
