import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Event with _$Event {
  const Event._();

  @Implements<DescriptiveModel>()
  const factory Event({
    String? id,
    String? parentId,
    String? groupId,
    String? placeId,
    @Default(true) bool blocked,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromDatabase(Map<String, dynamic> row) => Event.fromJson({
        ...row,
        'blocked': row['blocked'] == 1,
        'id': row['id'] != null ? utf8.decode(row['id']) : null,
        'parentId': row['parentId'] != null ? utf8.decode(row['parentId']) : null,
        
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        'blocked': blocked ? 1 : 0,
      };
}

enum EventStatus {
  confirmed,
  draft,
  cancelled,
}

enum RepeatType {
  daily,
  weekly,
  monthly,
  yearly,
}
