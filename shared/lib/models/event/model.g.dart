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
      start: _$JsonConverterFromJson<int, DateTime>(
          json['start'], const DateTimeConverter().fromJson),
      end: _$JsonConverterFromJson<int, DateTime>(
          json['end'], const DateTimeConverter().fromJson),
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
      'start': _$JsonConverterToJson<int, DateTime>(
          instance.start, const DateTimeConverter().toJson),
      'end': _$JsonConverterToJson<int, DateTime>(
          instance.end, const DateTimeConverter().toJson),
      'status': _$EventStatusEnumMap[instance.status]!,
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

_$_EventGroup _$$_EventGroupFromJson(Map<String, dynamic> json) =>
    _$_EventGroup(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      open: json['open'] as bool? ?? true,
      image: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['image'], const Uint8ListConverter().fromJson),
    );

Map<String, dynamic> _$$_EventGroupToJson(_$_EventGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'open': instance.open,
      'image': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.image, const Uint8ListConverter().toJson),
    };
