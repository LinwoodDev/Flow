import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/helpers/converter.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Event with _$Event {
  const Event._();

  const factory Event({
    @Default(-1) int id,
    int? parentId,
    int? groupId,
    int? placeId,
    @Default(true) bool blocked,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    @Default(EventTime.fixed()) EventTime time,
    @Default(EventStatus.confirmed) EventStatus status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  bool collidesWith(Event event) {
    return (event.time.end == null ||
            (time.start?.isBefore(event.time.end!) ?? true)) &&
        (event.time.start == null ||
            (time.end?.isAfter(event.time.start!) ?? true));
  }
}

@freezed
class EventTime with _$EventTime {
  const factory EventTime.fixed({
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
  }) = FixedEventTime;

  const factory EventTime.repeating({
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Default(-1) int id,
    @Default(RepeatType.daily) RepeatType type,
    @Default(1) int interval,
    @Default(0) int variation,
    @Default(0) int count,
    @DateTimeConverter() DateTime? until,
    @Default([]) List<int> exceptions,
  }) = RepeatingEventTime;

  const factory EventTime.auto({
    @Default(-1) int groupId,
    @DateTimeConverter() DateTime? searchStart,
    @Default(60) int duration,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
  }) = AutoEventTime;

  factory EventTime.fromJson(Map<String, dynamic> json) =>
      _$EventTimeFromJson(json);
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
