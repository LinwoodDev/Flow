import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqlite3/common.dart';

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

abstract class EventService {
  FutureOr<List<Event>> getEvents({
    EventStatus? status,
  });
}

class EventDatabaseService extends EventService implements DatabaseService {
  @override
  final CommonDatabase db;

  EventDatabaseService(this.db);

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
  FutureOr<void> migrate(int version) {}

  @override
  List<Event> getEvents({EventStatus? status}) {
    final statement = db.prepare("""
      SELECT * FROM events
      ${status != null ? 'WHERE status = ?' : ''}
    """, persistent: true);
    final params = [];
    if (status != null) {
      params.add(status.toString());
    }
    final result = statement.select(params);
    return result.map((row) => Event.fromJson(row)).toList();
  }
}

abstract class EventGroupService {
  FutureOr<List<EventGroup>> getGroups();
}

@freezed
class EventGroup with _$EventGroup {
  const factory EventGroup({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String description,
    @Default([]) List<int> image,
  }) = _EventGroup;

  factory EventGroup.fromJson(Map<String, dynamic> json) =>
      _$EventGroupFromJson(json);
}

class EventGroupManager with DatabaseService {
  @override
  final CommonDatabase db;

  EventGroupManager(this.db);

  @override
  FutureOr<void> create() {
    db.execute("""
      CREATE TABLE IF NOT EXISTS eventGroups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        image TEXT
      )
    """);
  }

  @override
  FutureOr<void> migrate(int version) {}
}
