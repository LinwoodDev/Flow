import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';

import '../../model.dart';
import '../model.dart';

part 'model.mapper.dart';

@MappableEnum()
enum CalendarItemType { appointment, moment, pending }

@MappableClass()
sealed class CalendarItem
    with CalendarItemMappable, IdentifiedModel, NamedModel, DescriptiveModel {
  @override
  final Uint8List? id;
  @override
  final String name, description;
  final String location;
  final Uint8List? eventId;
  final DateTime? start, end;
  final EventStatus status;

  const CalendarItem({
    this.id,
    this.name = '',
    this.description = '',
    this.location = '',
    this.eventId,
    this.start,
    this.end,
    this.status = EventStatus.confirmed,
  });

  factory CalendarItem.fromDatabase(Map<String, dynamic> row) =>
      FixedCalendarItemMapper.fromMap(row);

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
        ...toMap(),
      };
}

@MappableClass()
final class FixedCalendarItem extends CalendarItem
    with FixedCalendarItemMappable {
  const FixedCalendarItem({
    super.id,
    super.name,
    super.description,
    super.location,
    super.eventId,
    super.start,
    super.end,
    super.status,
  });
}

@MappableClass()
final class RepeatingCalendarItem extends CalendarItem
    with RepeatingCalendarItemMappable {
  final RepeatType repeatType;
  final int interval, variation, count;
  final DateTime? until;
  final List<int> exceptions;

  const RepeatingCalendarItem({
    super.id,
    super.name,
    super.description,
    super.location,
    super.eventId,
    super.start,
    super.end,
    super.status,
    this.repeatType = RepeatType.daily,
    this.interval = 1,
    this.variation = 0,
    this.count = 0,
    this.until,
    this.exceptions = const [],
  });
}

@MappableClass()
final class AutoCalendarItem extends CalendarItem
    with AutoCalendarItemMappable {
  final RepeatType repeatType;
  final int interval, variation, count;
  final DateTime? until;
  final List<int> exceptions;
  final Uint8List? autoGroupId;
  final DateTime? searchStart;
  final int autoDuration;

  const AutoCalendarItem({
    super.id,
    super.name,
    super.description,
    super.location,
    super.eventId,
    super.status,
    super.start,
    super.end,
    this.repeatType = RepeatType.daily,
    this.interval = 1,
    this.variation = 0,
    this.count = 0,
    this.until,
    this.exceptions = const [],
    this.autoGroupId,
    this.searchStart,
    this.autoDuration = 60,
  });
}
