// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      parentId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['parentId'], const MultihashConverter().fromJson),
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'parentId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.parentId, const MultihashConverter().toJson),
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
