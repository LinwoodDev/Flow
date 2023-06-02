// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      parentId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['parentId'], const MultihashConverter().fromJson),
      groupId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['groupId'], const MultihashConverter().fromJson),
      placeId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['placeId'], const MultihashConverter().fromJson),
      blocked: json['blocked'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      extra: json['extra'] as String?,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'parentId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.parentId, const MultihashConverter().toJson),
      'groupId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.groupId, const MultihashConverter().toJson),
      'placeId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.placeId, const MultihashConverter().toJson),
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
