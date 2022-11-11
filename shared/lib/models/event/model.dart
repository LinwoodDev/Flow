import 'dart:typed_data';

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

@freezed
class EventGroup with _$EventGroup {
  const factory EventGroup({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default(true) bool open,
    @Uint8ListConverter() Uint8List? image,
  }) = _EventGroup;

  factory EventGroup.fromJson(Map<String, dynamic> json) =>
      _$EventGroupFromJson(json);
}
