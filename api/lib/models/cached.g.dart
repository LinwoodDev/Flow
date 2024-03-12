// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CachedDataImpl _$$CachedDataImplFromJson(Map<String, dynamic> json) =>
    _$CachedDataImpl(
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CalendarItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: (json['notes'] as List<dynamic>?)
              ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CachedDataImplToJson(_$CachedDataImpl instance) =>
    <String, dynamic>{
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'events': instance.events,
      'items': instance.items,
      'notes': instance.notes,
    };
