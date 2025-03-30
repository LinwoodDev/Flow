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
    await service.userGroup.create(db);
    await service.userNotebook.create(db);
    await service.groupNotebook.create(db);
    await service.userLabel.create(db);
    await service.groupLabel.create(db);
    await db.execute("ALTER TABLE places RENAME TO resources");
    await db.execute("PRAGMA foreign_keys=off");

    // Migrate events
    await db.transaction((txn) async {
      await service.event.create(txn, 'events_temp');
      await txn.execute(
        "INSERT INTO events_temp SELECT id, parentId, blocked, name, description, location, extra FROM events",
      );
      await txn.execute(
        "INSERT INTO eventResources(eventId, resourceId) "
        "SELECT id, placeId FROM events WHERE placeId IS NOT NULL",
      );
      await txn.execute(
        "INSERT INTO eventGroups(eventId, groupId) "
        "SELECT id, groupId FROM events WHERE groupId IS NOT NULL",
      );
      await txn.execute("DROP TABLE events");
      await txn.execute("ALTER TABLE events_temp RENAME TO events");
    });

    // Migrate calendarItems
    await db.transaction((txn) async {
      await service.calendarItem.create(txn, 'calendarItems_temp');
      await txn.execute(
        "INSERT INTO calendarItems_temp "
        "SELECT runtimeType, id, name, description, location, eventId, start, end, "
        "status, repeatType, interval, variation, count, until, exceptions, "
        "autoGroupId, searchStart, autoDuration "
        "FROM calendarItems",
      );
      await txn.execute(
        "INSERT INTO calendarItemResources(itemId, resourceId) "
        "SELECT id, placeId FROM calendarItems WHERE placeId IS NOT NULL",
      );
      await txn.execute(
        "INSERT INTO calendarItemGroups(itemId, groupId) "
        "SELECT id, groupId FROM calendarItems WHERE groupId IS NOT NULL",
      );
      await txn.execute("DROP TABLE calendarItems");
      await txn
          .execute("ALTER TABLE calendarItems_temp RENAME TO calendarItems");
    });

    // Migrate users
    await db.transaction((txn) async {
      await service.user.create(txn, 'users_temp');
      await txn.execute(
        "INSERT INTO users_temp "
        "SELECT id, name, email, description, phone, image FROM users",
      );
      await txn.execute(
        "INSERT INTO userGroups(userId, groupId) "
        "SELECT id, groupId FROM users WHERE groupId IS NOT NULL",
      );
      await txn.execute("DROP TABLE users");
      await txn.execute("ALTER TABLE users_temp RENAME TO users");
    });
    await db.execute("PRAGMA foreign_keys=on");
  }
}
