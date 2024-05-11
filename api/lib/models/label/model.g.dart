// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LabelImpl _$$LabelImplFromJson(Map<String, dynamic> json) => _$LabelImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      color: (json['color'] as num?)?.toInt() ?? kColorBlack,
    );

Map<String, dynamic> _$$LabelImplToJson(_$LabelImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
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
