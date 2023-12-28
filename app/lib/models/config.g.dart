// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigFileImpl _$$ConfigFileImplFromJson(Map<String, dynamic> json) =>
    _$ConfigFileImpl(
      remotes: (json['remotes'] as List<dynamic>?)
          ?.map((e) => RemoteStorage.fromJson(e as Map<String, dynamic>))
          .toList(),
      passwords: (json['passwords'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ConfigFileImplToJson(_$ConfigFileImpl instance) =>
    <String, dynamic>{
      'remotes': instance.remotes,
      'passwords': instance.passwords,
    };
