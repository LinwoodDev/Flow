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
    };

_$FixedAppointment _$$FixedAppointmentFromJson(Map<String, dynamic> json) =>
    _$FixedAppointment(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: json['eventId'] as int,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FixedAppointmentToJson(_$FixedAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': instance.eventId,
      'status': _$EventStatusEnumMap[instance.status]!,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };

const _$EventStatusEnumMap = {
  EventStatus.confirmed: 'confirmed',
  EventStatus.draft: 'draft',
  EventStatus.cancelled: 'cancelled',
};

_$RepeatingAppointment _$$RepeatingAppointmentFromJson(
        Map<String, dynamic> json) =>
    _$RepeatingAppointment(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: json['eventId'] as int?,
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

Map<String, dynamic> _$$RepeatingAppointmentToJson(
        _$RepeatingAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': instance.eventId,
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

_$AutoAppointment _$$AutoAppointmentFromJson(Map<String, dynamic> json) =>
    _$AutoAppointment(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: json['eventId'] as int?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      autoGroupId: json['autoGroupId'] as int? ?? -1,
      searchStart:
          const DateTimeConverter().fromJson(json['searchStart'] as int?),
      autoDuration: json['autoDuration'] as int? ?? 60,
      start: const DateTimeConverter().fromJson(json['start'] as int?),
      end: const DateTimeConverter().fromJson(json['end'] as int?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AutoAppointmentToJson(_$AutoAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': instance.eventId,
      'status': _$EventStatusEnumMap[instance.status]!,
      'autoGroupId': instance.autoGroupId,
      'searchStart': const DateTimeConverter().toJson(instance.searchStart),
      'autoDuration': instance.autoDuration,
      'start': const DateTimeConverter().toJson(instance.start),
      'end': const DateTimeConverter().toJson(instance.end),
      'runtimeType': instance.$type,
    };

_$_Moment _$$_MomentFromJson(Map<String, dynamic> json) => _$_Moment(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      eventId: json['eventId'] as int?,
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.confirmed,
      time: const DateTimeConverter().fromJson(json['time'] as int?),
    );

Map<String, dynamic> _$$_MomentToJson(_$_Moment instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'eventId': instance.eventId,
      'status': _$EventStatusEnumMap[instance.status]!,
      'time': const DateTimeConverter().toJson(instance.time),
    };
