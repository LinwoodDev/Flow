import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/converter.dart';
import '../../model.dart';
import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum CalendarItemType { appointment, moment, pending }

@freezed
class CalendarItem with _$CalendarItem, DescriptiveModel {
  const CalendarItem._();

  const factory CalendarItem.fixed({
    String? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    String? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
  }) = FixedCalendarItem;

  const factory CalendarItem.repeating({
    String? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    String? eventId,
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
    String? id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    String? eventId,
    @Default(EventStatus.confirmed) EventStatus status,
    @DateTimeConverter() DateTime? start,
    @DateTimeConverter() DateTime? end,
    String? autoGroupId,
    @DateTimeConverter() DateTime? searchStart,
    @Default(60) int autoDuration,
  }) = AutoCalendarItem;

  factory CalendarItem.fromJson(Map<String, dynamic> json) =>
      _$CalendarItemFromJson(json);

  factory CalendarItem.fromDatabase(Map<String, dynamic> json) =>
      CalendarItem.fromJson({
        ...json,
        'id': json['id']?.toString(),
        'eventId': json['eventId']?.toString(),
        'autoGroupId': json['autoGroupId']?.toString(),
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
    return (date.end == null || (date.start?.isBefore(date.end!) ?? true)) &&
        (date.start == null || (date.end?.isAfter(date.start!) ?? true));
  }

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        'id': int.tryParse(id ?? ''),
        'eventId': int.tryParse(eventId ?? ''),
        ...maybeMap(
            orElse: () => {},
            auto: (a) => {
                  'autoGroupId': int.tryParse(a.autoGroupId ?? ''),
                }),
      };
}
