// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FixedCalendarItemImpl _$$FixedCalendarItemImplFromJson(
        Map<String, dynamic> json) =>
    _$FixedCalendarItemImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      groupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['groupId'], const MultihashConverter().fromJson),
      placeId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['placeId'], const MultihashConverter().fromJson),
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start:
          const DateTimeConverter().fromJson((json['start'] as num?)?.toInt()),
      end: const DateTimeConverter().fromJson((json['end'] as num?)?.toInt()),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FixedCalendarItemImplToJson(
        _$FixedCalendarItemImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'groupId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.groupId, const MultihashConverter().toJson),
      'placeId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.placeId, const MultihashConverter().toJson),
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

_$RepeatingCalendarItemImpl _$$RepeatingCalendarItemImplFromJson(
        Map<String, dynamic> json) =>
    _$RepeatingCalendarItemImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      groupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['groupId'], const MultihashConverter().fromJson),
      placeId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['placeId'], const MultihashConverter().fromJson),
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start:
          const DateTimeConverter().fromJson((json['start'] as num?)?.toInt()),
      end: const DateTimeConverter().fromJson((json['end'] as num?)?.toInt()),
      repeatType:
          $enumDecodeNullable(_$RepeatTypeEnumMap, json['repeatType']) ??
              RepeatType.daily,
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      variation: (json['variation'] as num?)?.toInt() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      until:
          const DateTimeConverter().fromJson((json['until'] as num?)?.toInt()),
      exceptions: (json['exceptions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RepeatingCalendarItemImplToJson(
        _$RepeatingCalendarItemImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'groupId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.groupId, const MultihashConverter().toJson),
      'placeId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.placeId, const MultihashConverter().toJson),
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

_$AutoCalendarItemImpl _$$AutoCalendarItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AutoCalendarItemImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      groupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['groupId'], const MultihashConverter().fromJson),
      placeId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['placeId'], const MultihashConverter().fromJson),
      eventId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['eventId'], const MultihashConverter().fromJson),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start:
          const DateTimeConverter().fromJson((json['start'] as num?)?.toInt()),
      end: const DateTimeConverter().fromJson((json['end'] as num?)?.toInt()),
      autoGroupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['autoGroupId'], const MultihashConverter().fromJson),
      searchStart: const DateTimeConverter()
          .fromJson((json['searchStart'] as num?)?.toInt()),
      autoDuration: (json['autoDuration'] as num?)?.toInt() ?? 60,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AutoCalendarItemImplToJson(
        _$AutoCalendarItemImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'groupId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.groupId, const MultihashConverter().toJson),
      'placeId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.placeId, const MultihashConverter().toJson),
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
