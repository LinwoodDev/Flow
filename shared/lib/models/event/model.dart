import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Event with _$Event {
  const Event._();

  @Implements<DescriptiveModel>()
  const factory Event({
    @Default(-1) int id,
    int? parentId,
    int? groupId,
    int? placeId,
    @Default(true) bool blocked,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromDatabase(Map<String, dynamic> row) {
    return Event.fromJson({
      ...row,
      'blocked': row['blocked'] == 1,
    });
  }

  Map<String, dynamic> toDatabase() {
    return {
      ...toJson(),
      'blocked': blocked ? 1 : 0,
    };
  }
}

abstract class EventItem extends DescriptiveModel {
  int? get eventId;
  EventStatus get status;
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
