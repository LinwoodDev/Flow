// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FixedCalendarItem _$$FixedCalendarItemFromJson(Map<String, dynamic> json) =>
    _$FixedCalendarItem(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FixedCalendarItemToJson(_$FixedCalendarItem instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.eventId, const MultihashConverter().toJson),
      'status': _$EventStatusEnumMap[instance.status]!,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$EventStatusEnumMap = {
  EventStatus.confirmed: 'confirmed',
  EventStatus.draft: 'draft',
  EventStatus.cancelled: 'cancelled',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$RepeatingCalendarItem _$$RepeatingCalendarItemFromJson(
        Map<String, dynamic> json) =>
    _$RepeatingCalendarItem(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      repeatType:
          $enumDecodeNullable(_$RepeatTypeEnumMap, json['repeatType']) ??
              RepeatType.daily,
      interval: json['interval'] as int? ?? 1,
      variation: json['variation'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      until: const DateTimeConverter().fromJson(json['until'] as int?),
      exceptions: (json['exceptions'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RepeatingCalendarItemToJson(
        _$RepeatingCalendarItem instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.eventId, const MultihashConverter().toJson),
      'status': _$EventStatusEnumMap[instance.status]!,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'repeatType': _$RepeatTypeEnumMap[instance.repeatType]!,
      'interval': instance.interval,
      'variation': instance.variation,
      'count': instance.count,
      'until': const DateTimeConverter().toJson(instance.until),
      'exceptions': instance.exceptions,
      'runtimeType': instance.$type,
    };

const _$RepeatTypeEnumMap = {
  RepeatType.daily: 'daily',
  RepeatType.weekly: 'weekly',
  RepeatType.monthly: 'monthly',
  RepeatType.yearly: 'yearly',
};

_$AutoCalendarItem _$$AutoCalendarItemFromJson(Map<String, dynamic> json) =>
    _$AutoCalendarItem(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      autoGroupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['autoGroupId'], const MultihashConverter().fromJson),
      searchStart:
          const DateTimeConverter().fromJson(json['searchStart'] as int?),
      autoDuration: json['autoDuration'] as int? ?? 60,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AutoCalendarItemToJson(_$AutoCalendarItem instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.eventId, const MultihashConverter().toJson),
      'status': _$EventStatusEnumMap[instance.status]!,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'autoGroupId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.autoGroupId, const MultihashConverter().toJson),
      'searchStart': const DateTimeConverter().toJson(instance.searchStart),
      'autoDuration': instance.autoDuration,
      'runtimeType': instance.$type,
    };
