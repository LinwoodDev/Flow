// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventGroup _$$_EventGroupFromJson(Map<String, dynamic> json) =>
    _$_EventGroup(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: (json['image'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [],
    );

Map<String, dynamic> _$$_EventGroupToJson(_$_EventGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
