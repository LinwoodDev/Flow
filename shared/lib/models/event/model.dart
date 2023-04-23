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
        'id': row['id']?.toString(),
        'parentId': row['parentId']?.toString(),
        'groupId': row['groupId']?.toString(),
        'placeId': row['placeId']?.toString(),
      });

  Map<String, dynamic> toDatabase() => {
        ...toJson(),
        'blocked': blocked ? 1 : 0,
        'id': int.tryParse(id ?? ''),
        'parentId': int.tryParse(parentId ?? ''),
        'groupId': int.tryParse(groupId ?? ''),
        'placeId': int.tryParse(placeId ?? ''),
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
