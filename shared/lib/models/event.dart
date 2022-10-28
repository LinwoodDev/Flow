import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../database.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    @Default(-1) int id,
    int? groupId,
    int? placeId,
    @Default('') String name,
    @Default('') String description,
    @Default('') String location,
    DateTime? start,
    DateTime? end,
    @Default(EventStatus.accepted) EventStatus status,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

enum EventStatus {
  pending,
  accepted,
  declined,
}

class EventManager extends TableManager {
  EventManager(super.db);

  @override
  void create() {
    db.execute("""
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY,
        groupId INTEGER,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        location TEXT,
        placeId INTEGER,
        start TEXT,
        end TEXT,
        status TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(int version) {
    // TODO: implement migrate
    throw UnimplementedError();
  }
}
