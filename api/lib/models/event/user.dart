import 'dart:typed_data';

import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/services/database.dart';

class EventUserDatabaseConnector extends DatabaseModelConnector<User, Event> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "eventId";

  @override
  String get connectedTableName => "events";

  @override
  String get tableName => "eventUsers";

  @override
  Future<List<Event>> getConnected(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN events ON eventId = events.id',
      limit: limit,
      offset: offset,
      where: 'userId = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => Event.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<User>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN users ON userId = users.id',
      limit: limit,
      offset: offset,
      where: 'eventId = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => User.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'userId';

  @override
  String get itemTableName => 'users';
}
