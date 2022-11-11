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
    @Default(false) bool done,
    int? eventId,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
