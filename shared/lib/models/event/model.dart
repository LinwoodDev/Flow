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
    @Default(EventStatus.accepted) EventStatus status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

enum EventStatus {
  pending,
  accepted,
  declined,
}

@freezed
class EventGroup with _$EventGroup {
  const factory EventGroup({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<int> image,
  }) = _EventGroup;

  factory EventGroup.fromJson(Map<String, dynamic> json) =>
      _$EventGroupFromJson(json);
}
