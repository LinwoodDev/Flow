// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

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
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      status: $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.accepted,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'placeId': instance.placeId,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'status': _$EventStatusEnumMap[instance.status]!,
    };

const _$EventStatusEnumMap = {
  EventStatus.pending: 'pending',
  EventStatus.accepted: 'accepted',
  EventStatus.declined: 'declined',
};
