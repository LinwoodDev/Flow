import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/resource/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

class CalendarItemResourceDatabaseConnector
    extends ResourceDatabaseConnector<CalendarItem> {
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "calendarItems";

  @override
  String get tableName => "calendarItemResources";

  @override
  CalendarItem decode(Map<String, dynamic> data) =>
      CalendarItem.fromDatabase(data);

  @override
  Future<void> migrate(Database db, int version) async {
    await super.migrate(db, version);
    if (version < 4) {
      await db.execute(
          "INSERT INTO calendarItemResources(itemId, resourceId) SELECT id, placeId FROM calendarItems");
      await db.execute("ALTER TABLE calendarItems DROP COLUMN placeId");
    }
  }
}
