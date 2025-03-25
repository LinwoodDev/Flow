import 'dart:typed_data';

import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/services/database.dart';

class CalendarItemGroupDatabaseConnector
    extends DatabaseModelConnector<Group, CalendarItem> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "calendarItems";

  @override
  String get tableName => "calendaritemGroups";

  @override
  Future<List<CalendarItem>> getConnected(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN calendarItems ON itemId = calendarItems.id',
      limit: limit,
      offset: offset,
      where: 'groupId = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => CalendarItem.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<Group>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN groups ON groupId = groups.id',
      limit: limit,
      offset: offset,
      where: 'itemId = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => Group.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'groupId';

  @override
  String get itemTableName => 'groups';
}
