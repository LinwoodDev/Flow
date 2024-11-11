import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/converter.dart';
import '../../model.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum CalendarItemType { appointment, moment, pending }

@freezed
class CalendarItem
    with _$CalendarItem, IdentifiedModel, NamedModel, DescriptiveModel {
  const CalendarItem._();

  const factory CalendarItem.fixed({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    @Uint8ListConverter() Uint8List? groupId,
    @Uint8ListConverter() Uint8List? placeId,
    @Uint8ListConverter() Uint8List? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
  }) = FixedCalendarItem;

  const factory CalendarItem.repeating({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    @Uint8ListConverter() Uint8List? groupId,
    @Uint8ListConverter() Uint8List? placeId,
    @Uint8ListConverter() Uint8List? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Default(RepeatType.daily) RepeatType repeatType,
    @Default(1) int interval,
    @Default(0) int variation,
    @Default(0) int count,
    @DateTimeConverter() DateTime? until,
    @Default([]) List<int> exceptions,
  }) = RepeatingCalendarItem;

  const factory CalendarItem.auto({
    @Uint8ListConverter() Uint8List? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    @Uint8ListConverter() Uint8List? groupId,
    @Uint8ListConverter() Uint8List? placeId,
    @Uint8ListConverter() Uint8List? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    @Uint8ListConverter() Uint8List? autoGroupId,
    @DateTimeConverter() DateTime? searchStart,
    @Default(60) int autoDuration,
  }) = AutoCalendarItem;

  factory CalendarItem.fromJson(Map<String, dynamic> json) =>
      _$CalendarItemFromJson(json);

  factory CalendarItem.fromDatabase(Map<String, dynamic> row) =>
      CalendarItem.fromJson({
        ...row,
      });

  CalendarItemType get type {
    if (start == null && end == null) {
      return CalendarItemType.pending;
    } else if (start == end) {
      return CalendarItemType.moment;
    } else {
      return CalendarItemType.appointment;
    }
  }

  bool collidesWith(CalendarItem date) {
    return (end == null || (date.start?.isBefore(end!) ?? true)) &&
        (start == null || (date.end?.isAfter(start!) ?? true));
  }

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
      };
}
