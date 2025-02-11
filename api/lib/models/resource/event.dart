import 'dart:async';

import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/resource/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class EventResourceDatabaseConnector extends ResourceDatabaseConnector<Event> {
  @override
  String get connectedIdName => "eventId";

  @override
  String get connectedTableName => "events";

  @override
  String get tableName => "eventResources";

  @override
  Event decode(Map<String, dynamic> data) => Event.fromDatabase(data);

  @override
  Future<void> migrate(Database db, int version) async {
    if (version < 4) {
      await create(db);
    }
  }
}
