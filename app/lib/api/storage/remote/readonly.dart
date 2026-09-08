import 'dart:async';
import 'dart:typed_data';

import 'package:flow_api/models/event/database.dart';
import 'package:flow_api/models/event/item/database.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:sqflite_common/sqlite_api.dart';

/// Read access to a subscription cache. Synchronization writes through the
/// owning database service, never through these user-facing services.
class ReadOnlyEventService extends EventDatabaseService {
  ReadOnlyEventService(Database database) {
    opened(database);
  }

  @override
  bool get isEditable => false;
  @override
  Future<Event?> createEvent(Event event) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<bool> updateEvent(Event event) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<bool> deleteEvent(Uint8List id) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<void> clear() async => throw UnsupportedError('Read-only source');
}

class ReadOnlyCalendarItemService extends CalendarItemDatabaseService {
  ReadOnlyCalendarItemService(Database database) {
    opened(database);
  }

  @override
  bool get isEditable => false;
  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<bool> updateCalendarItem(CalendarItem item) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<bool> deleteCalendarItem(Uint8List id) async =>
      throw UnsupportedError('Read-only source');
  @override
  Future<void> clear() async => throw UnsupportedError('Read-only source');
}
