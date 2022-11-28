import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Team with _$Team {
  const factory Team({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
