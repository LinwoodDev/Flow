// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      parentId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['parentId'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']),
      priority: json['priority'] as int? ?? 0,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'parentId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.parentId, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'status': _$NoteStatusEnumMap[instance.status],
      'priority': instance.priority,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$NoteStatusEnumMap = {
  NoteStatus.todo: 'todo',
  NoteStatus.inProgress: 'inProgress',
  NoteStatus.done: 'done',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
