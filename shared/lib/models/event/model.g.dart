// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as int? ?? -1,
      groupId: json['groupId'] as int?,
      placeId: json['placeId'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'placeId': instance.placeId,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'status': _$EventStatusEnumMap[instance.status]!,
    };

const _$EventStatusEnumMap = {
  EventStatus.confirmed: 'confirmed',
  EventStatus.draft: 'draft',
  EventStatus.cancelled: 'cancelled',
};

_$_Repetition _$$_RepetitionFromJson(Map<String, dynamic> json) =>
    _$_Repetition(
      id: json['id'] as int? ?? -1,
      type: $enumDecodeNullable(_$RepeatTypeEnumMap, json['type']) ??
          RepeatType.daily,
      interval: json['interval'] as int? ?? 1,
      variation: json['variation'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      until: const DateTimeConverter().fromJson(json['until'] as int?),
    );

Map<String, dynamic> _$$_RepetitionToJson(_$_Repetition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$RepeatTypeEnumMap[instance.type]!,
      'interval': instance.interval,
      'variation': instance.variation,
      'count': instance.count,
      'until': const DateTimeConverter().toJson(instance.until),
    };

const _$RepeatTypeEnumMap = {
  RepeatType.daily: 'daily',
  RepeatType.weekly: 'weekly',
  RepeatType.monthly: 'monthly',
  RepeatType.yearly: 'yearly',
};
