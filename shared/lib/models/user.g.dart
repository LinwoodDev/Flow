// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      description: json['description'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      image: (json['image'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [],
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'phone': instance.phone,
      'image': instance.image,
    };

_$_UserGroup _$$_UserGroupFromJson(Map<String, dynamic> json) => _$_UserGroup(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$_UserGroupToJson(_$_UserGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
