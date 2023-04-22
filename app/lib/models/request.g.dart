// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_APIRequest _$$_APIRequestFromJson(Map<String, dynamic> json) =>
    _$_APIRequest(
      method: json['method'] as String,
      authority: json['authority'] as String,
      path: json['path'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      body: json['body'] as String? ?? '',
    );

Map<String, dynamic> _$$_APIRequestToJson(_$_APIRequest instance) =>
    <String, dynamic>{
      'method': instance.method,
      'authority': instance.authority,
      'path': instance.path,
      'headers': instance.headers,
      'body': instance.body,
    };
