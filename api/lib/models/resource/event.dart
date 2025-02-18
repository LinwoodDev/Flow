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
    await super.migrate(db, version);
    if (version < 4) {
      await db.execute(
          "INSERT INTO events SELECT id, parentId, groupId, blocked, name, description, location, extra FROM events_old");
      await db.execute(
          "INSERT INTO eventResources(eventId, resourceId) SELECT id, placeId FROM events_old");
      await db.execute("DROP TABLE events_old");
    }
  }
}
