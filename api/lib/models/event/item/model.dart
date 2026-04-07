import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';

import '../../model.dart';
import '../model.dart';

part 'model.mapper.dart';

List<int> _decodeExceptions(dynamic value) {
  if (value == null) return const [];
  if (value is List) {
    return value
        .map((e) => e is num ? e.toInt() : int.tryParse('$e'))
        .whereType<int>()
        .toList();
  }
  if (value is String && value.isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is List) {
        return decoded
            .map((e) => e is num ? e.toInt() : int.tryParse('$e'))
            .whereType<int>()
            .toList();
      }
    } catch (_) {
      return const [];
    }
  }
  return const [];
}

int _encodeBitMask(Iterable<int> values, {required int min, required int max}) {
  var mask = 0;
  for (final value in values.toSet()) {
    if (value < min || value > max) continue;
    mask |= 1 << (value - min);
  }
  return mask;
}

List<int> _decodeBitMask(int mask, {required int min, required int max}) {
  if (mask <= 0) return const [];
  final values = <int>[];
  for (var i = min; i <= max; i++) {
    if ((mask & (1 << (i - min))) != 0) {
      values.add(i);
    }
  }
  return values;
}

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

  factory CalendarItem.fromDatabase(Map<String, dynamic> row) {
    final mapped = {...row, 'exceptions': _decodeExceptions(row['exceptions'])};
    final runtimeType = row['runtimeType']?.toString();
    if (runtimeType == 'RepeatingCalendarItem' || runtimeType == 'repeating') {
      return RepeatingCalendarItemMapper.fromMap(mapped);
    }
    return FixedCalendarItemMapper.fromMap(mapped);
  }

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

  Map<String, dynamic> toDatabase() => {...toMap()};
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

  @override
  Map<String, dynamic> toDatabase() => {
    ...toMap(),
    'runtimeType': 'FixedCalendarItem',
  };
}

@MappableClass()
final class RepeatingCalendarItem extends CalendarItem
    with RepeatingCalendarItemMappable {
  final RepeatType repeatType;
  final int interval, variation, count;
  final DateTime? until;
  final List<int> exceptions;

  static int encodeWeeklyWeekdays(Iterable<int> weekdays) =>
      _encodeBitMask(weekdays, min: DateTime.monday, max: DateTime.sunday);

  static List<int> decodeWeeklyWeekdays(int variation) =>
      _decodeBitMask(variation, min: DateTime.monday, max: DateTime.sunday);

  static int encodeMonthlyMonthDays(Iterable<int> monthDays) =>
      _encodeBitMask(monthDays, min: 1, max: 31);

  static List<int> decodeMonthlyMonthDays(int variation) =>
      _decodeBitMask(variation, min: 1, max: 31);

  List<int> get weeklyVariationWeekdays => decodeWeeklyWeekdays(variation);

  List<int> get monthlyVariationMonthDays => decodeMonthlyMonthDays(variation);

  List<int> get weeklyWeekdays {
    final weekdays = weeklyVariationWeekdays;
    if (weekdays.isNotEmpty) return weekdays;
    final weekday = start?.weekday;
    return weekday == null ? const [] : [weekday];
  }

  List<int> get monthlyMonthDays {
    final monthDays = monthlyVariationMonthDays;
    if (monthDays.isNotEmpty) return monthDays;
    final day = start?.day;
    return day == null ? const [] : [day];
  }

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

  @override
  Map<String, dynamic> toDatabase() => {
    ...toMap(),
    'runtimeType': 'RepeatingCalendarItem',
    'exceptions': jsonEncode(exceptions),
  };
}
