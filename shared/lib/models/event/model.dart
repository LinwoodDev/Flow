import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/helpers/converter.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    @Default(-1) int id,
    int? groupId,
    int? placeId,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Default(EventStatus.confirmed) EventStatus status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

enum EventStatus {
  confirmed,
  draft,
  cancelled,
}

enum RepeatType {
  daily,
  weekly,
  monthly,
  yearly,
}

@freezed
class Repetition with _$Repetition {
  const factory Repetition({
    @Default(-1) int id,
    @Default(RepeatType.daily) RepeatType type,
    @Default(1) int interval,
    @Default(0) int variation,
    @Default(0) int count,
    @DateTimeConverter() DateTime? until,
  }) = _Repetition;

  factory Repetition.fromJson(Map<String, dynamic> json) =>
      _$RepetitionFromJson(json);
}
