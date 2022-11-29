import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    int? parentId,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
