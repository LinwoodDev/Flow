// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotebookImpl _$$NotebookImplFromJson(Map<String, dynamic> json) =>
    _$NotebookImpl(
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$NotebookImplToJson(_$NotebookImpl instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
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

_$NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => _$NoteImpl(
      notebookId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['notebookId'], const MultihashConverter().fromJson),
      id: _$JsonConverterFromJson<List<int>, Multihash>(
          json['id'], const MultihashConverter().fromJson),
      parentId: _$JsonConverterFromJson<List<int>, Multihash>(
          json['parentId'], const MultihashConverter().fromJson),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']),
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$NoteImplToJson(_$NoteImpl instance) =>
    <String, dynamic>{
      'notebookId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.notebookId, const MultihashConverter().toJson),
      'id': _$JsonConverterToJson<List<int>, Multihash>(
          instance.id, const MultihashConverter().toJson),
      'parentId': _$JsonConverterToJson<List<int>, Multihash>(
          instance.parentId, const MultihashConverter().toJson),
      'name': instance.name,
      'description': instance.description,
      'status': _$NoteStatusEnumMap[instance.status],
      'priority': instance.priority,
    };

const _$NoteStatusEnumMap = {
  NoteStatus.todo: 'todo',
  NoteStatus.inProgress: 'inProgress',
  NoteStatus.done: 'done',
};
