// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['id'], const Uint8ListConverter().fromJson),
      parentId: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['parentId'], const Uint8ListConverter().fromJson),
      groupId: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['groupId'], const Uint8ListConverter().fromJson),
      placeId: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['placeId'], const Uint8ListConverter().fromJson),
      blocked: json['blocked'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      extra: json['extra'] as String?,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.id, const Uint8ListConverter().toJson),
      'parentId': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.parentId, const Uint8ListConverter().toJson),
      'groupId': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.groupId, const Uint8ListConverter().toJson),
      'placeId': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.placeId, const Uint8ListConverter().toJson),
      'blocked': instance.blocked,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'extra': instance.extra,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
