// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$APIRequestImpl _$$APIRequestImplFromJson(Map<String, dynamic> json) =>
    _$APIRequestImpl(
      id: json['id'] as int? ?? -1,
      method: json['method'] as String,
      authority: json['authority'] as String,
      path: json['path'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      body: json['body'] as String? ?? '',
    );

Map<String, dynamic> _$$APIRequestImplToJson(_$APIRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'authority': instance.authority,
      'path': instance.path,
      'headers': instance.headers,
      'body': instance.body,
    };
