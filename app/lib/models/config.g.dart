// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConfigFile _$$_ConfigFileFromJson(Map<String, dynamic> json) =>
    _$_ConfigFile(
      remotes: (json['remotes'] as List<dynamic>?)
          ?.map((e) => RemoteStorage.fromJson(e as Map<String, dynamic>))
          .toList(),
      passwords: (json['passwords'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_ConfigFileToJson(_$_ConfigFile instance) =>
    <String, dynamic>{
      'remotes': instance.remotes,
      'passwords': instance.passwords,
    };
