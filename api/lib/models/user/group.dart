import 'dart:typed_data';

import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/services/database.dart';

class UserGroupDatabaseConnector extends DatabaseModelConnector<Group, User> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "userId";

  @override
  String get connectedTableName => "users";

  @override
  String get tableName => "userGroups";

  @override
  Future<List<User>> getConnected(
    Uint8List itemId, {
    int offset = 0,
    int limit = 50,
  }) async {
    final result = await db?.query(
      '$tableName JOIN users ON userId = users.id',
      limit: limit,
      offset: offset,
      where: '$connectedIdName = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => User.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<Group>> getItems(
    Uint8List connectId, {
    int offset = 0,
    int limit = 50,
  }) async {
    final result = await db?.query(
      '$tableName JOIN groups ON groupId = groups.id',
      limit: limit,
      offset: offset,
      where: '$itemIdName = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => Group.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'groupId';

  @override
  String get itemTableName => 'groups';
}
