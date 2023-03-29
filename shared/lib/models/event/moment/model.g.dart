// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

const _$EventStatusEnumMap = {
  EventStatus.confirmed: 'confirmed',
  EventStatus.draft: 'draft',
  EventStatus.cancelled: 'cancelled',
};
