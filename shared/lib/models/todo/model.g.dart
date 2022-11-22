// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as int? ?? -1,
      parentId: json['parentId'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$TodoStatusEnumMap, json['status']) ??
          TodoStatus.todo,
      priority: json['priority'] as int? ?? 0,
      eventId: json['eventId'] as int?,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'name': instance.name,
      'description': instance.description,
      'status': _$TodoStatusEnumMap[instance.status]!,
      'priority': instance.priority,
      'eventId': instance.eventId,
    };

const _$TodoStatusEnumMap = {
  TodoStatus.todo: 'todo',
  TodoStatus.inProgress: 'inProgress',
  TodoStatus.done: 'done',
};
