import 'dart:typed_data';

import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/services/database.dart';

class EventGroupDatabaseConnector extends DatabaseModelConnector<Group, Event> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "eventId";

  @override
  String get connectedTableName => "events";

  @override
  String get tableName => "eventGroups";

  @override
  Future<List<Event>> getConnected(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN events ON eventId = events.id',
      limit: limit,
      offset: offset,
      where: 'groupId = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => Event.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<Group>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN groups ON groupId = groups.id',
      limit: limit,
      offset: offset,
      where: 'eventId = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => Group.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'groupId';

  @override
  String get itemTableName => 'groups';
}
