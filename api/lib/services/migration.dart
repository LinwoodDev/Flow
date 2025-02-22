import 'package:flow_api/services/database.dart';
import 'package:sqflite_common/sqlite_api.dart';

Future<void> migrateDatabase(DatabaseService service, Database db,
    int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await service.label.create(db);
    await service.labelNote.create(db);
  }
  if (oldVersion < 3) {
    await db.execute("ALTER TABLE notes ADD notebookId BLOB(16)");
    await service.note.createNotebookDatabase(db);
    await db.transaction((txn) async {
      await txn.execute("ALTER TABLE calendarItems ADD groupId BLOB(16)");
      await txn.execute("ALTER TABLE calendarItems ADD placeId BLOB(16)");
    });
  }
  if (oldVersion < 4) {
    await service.eventGroup.create(db);
    await service.eventUser.create(db);
    await service.groupNote.create(db);
    await service.userNote.create(db);
    await service.calendarItemGroup.create(db);
    await service.calendarItemUser.create(db);
    await service.userResource.create(db);
    await service.groupResource.create(db);
    await service.eventResource.create(db);
    await service.calendarItemResource.create(db);
    await db.execute("ALTER TABLE places RENAME TO resources");
    await db.execute("PRAGMA foreign_keys=off");
    await db.transaction((txn) async {
      await service.event.create(txn, 'events_temp');
      await txn.execute(
          "INSERT INTO events_temp SELECT id, parentId, blocked, name, description, location, extra FROM events");
      await txn.execute(
          "INSERT INTO eventResources(eventId, resourceId) SELECT id, placeId FROM events");
      await txn.execute(
          "INSERT INTO eventGroups(eventId, groupId) SELECT id, groupId FROM events");
      await txn.execute("DROP TABLE events");
      await txn.execute("ALTER TABLE events_temp RENAME TO events");
    });
    await db.transaction((txn) async {
      await service.calendarItem.create(txn, 'calendarItems_temp');
      await txn.execute(
          "INSERT INTO calendarItems_temp SELECT id, parentId, blocked, name, description, location, extra FROM calendarItems");
      await txn.execute(
          "INSERT INTO calendarItemResources(itemId, resourceId) SELECT id, placeId FROM calendarItems");
      await txn.execute(
          "INSERT INTO calendarItemGroups(itemId, groupId) SELECT id, groupId FROM calendarItems");
      await txn.execute("DROP TABLE calendarItems");
      await txn
          .execute("ALTER TABLE calendarItems_temp RENAME TO calendarItems");
    });
    await db.execute("PRAGMA foreign_keys=on");
  }
}
