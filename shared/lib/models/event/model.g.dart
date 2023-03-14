// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as int? ?? -1,
      parentId: json['parentId'] as int?,
      groupId: json['groupId'] as int?,
      placeId: json['placeId'] as int?,
      blocked: json['blocked'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      time: json['time'] == null
          ? const EventTime.fixed()
          : EventTime.fromJson(json['time'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'groupId': instance.groupId,
      'placeId': instance.placeId,
      'blocked': instance.blocked,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'time': instance.time,
      'status': _$EventStatusEnumMap[instance.status]!,
    };

const _$EventStatusEnumMap = {
  EventStatus.confirmed: 'confirmed',
  EventStatus.draft: 'draft',
  EventStatus.cancelled: 'cancelled',
};

_$FixedEventTime _$$FixedEventTimeFromJson(Map<String, dynamic> json) =>
    _$FixedEventTime(
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FixedEventTimeToJson(_$FixedEventTime instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };

_$RepeatingEventTime _$$RepeatingEventTimeFromJson(Map<String, dynamic> json) =>
    _$RepeatingEventTime(
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      id: json['id'] as int? ?? -1,
      type: $enumDecodeNullable(_$RepeatTypeEnumMap, json['type']) ??
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

Map<String, dynamic> _$$RepeatingEventTimeToJson(
        _$RepeatingEventTime instance) =>
    <String, dynamic>{
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'id': instance.id,
      'type': _$RepeatTypeEnumMap[instance.type]!,
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

_$AutoEventTime _$$AutoEventTimeFromJson(Map<String, dynamic> json) =>
    _$AutoEventTime(
      groupId: json['groupId'] as int? ?? -1,
      searchStart:
          const DateTimeConverter().fromJson(json['searchStart'] as int?),
      duration: json['duration'] as int? ?? 60,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AutoEventTimeToJson(_$AutoEventTime instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'searchStart': const DateTimeConverter().toJson(instance.searchStart),
      'duration': instance.duration,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };
