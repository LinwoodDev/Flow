// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as int?,
      parentId: json['parentId'] as int?,
      groupId: json['groupId'] as int?,
      placeId: json['placeId'] as int?,
      blocked: json['blocked'] as bool? ?? true,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'groupId': instance.groupId,
      'placeId': instance.placeId,
      'blocked': instance.blocked,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
    };
