// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      id: json['id'] as int? ?? -1,
      parentId: json['parentId'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']),
      priority: json['priority'] as int? ?? 0,
      eventId: json['eventId'] as int?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'name': instance.name,
      'description': instance.description,
      'status': _$NoteStatusEnumMap[instance.status],
      'priority': instance.priority,
      'eventId': instance.eventId,
    };

const _$NoteStatusEnumMap = {
  NoteStatus.note: 'note',
  NoteStatus.inProgress: 'inProgress',
  NoteStatus.done: 'done',
};
