import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/database.dart';

part 'group.freezed.dart';
part 'group.g.dart';

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

class EventGroupManager extends TableManager {
  EventGroupManager(super.db);

  @override
  FutureOr<void> create() {
    db.execute("""
      CREATE TABLE IF NOT EXISTS groups (
        id INTEGER PRIMARY KEY,
        name VARCHAR(100) NOT NULL DEFAULT '',
        description TEXT,
        image BLOB
      )
    """);
  }

  @override
  FutureOr<void> migrate(int version) {}
}
