import 'dart:typed_data';

import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/services/database.dart';

class CalendarItemUserDatabaseConnector
    extends DatabaseModelConnector<User, CalendarItem> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "calendarItems";

  @override
  String get tableName => "calendarItemUsers";

  @override
  Future<List<CalendarItem>> getConnected(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN calendaritems ON itemId = calendarItems.id',
      limit: limit,
      offset: offset,
      where: 'userId = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => CalendarItem.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<User>> getItems(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN users ON userId = users.id',
      limit: limit,
      offset: offset,
      where: 'itemId = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => User.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'userId';

  @override
  String get itemTableName => 'users';
}
