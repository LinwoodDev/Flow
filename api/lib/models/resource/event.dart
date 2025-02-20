import 'package:flow_api/models/event/database.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/resource/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class EventResourceDatabaseConnector extends ResourceDatabaseConnector<Event> {
  final EventDatabaseService eventService;

  EventResourceDatabaseConnector(this.eventService);

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
      await db.execute("PRAGMA foreign_keys=off");
      await db.transaction((txn) async {
        await eventService.create(txn, 'events_temp');
        await txn.execute(
            "INSERT INTO events_temp SELECT id, parentId, groupId, blocked, name, description, location, extra FROM events");
        await txn.execute(
            "INSERT INTO eventResources(eventId, resourceId) SELECT id, placeId FROM events");
        await txn.execute("DROP TABLE events");
        await txn.execute("ALTER TABLE events_temp RENAME TO events");
      });
      await db.execute("PRAGMA foreign_keys=on");
    }
  }
}
