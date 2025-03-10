import 'dart:typed_data';

import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/services/database.dart';

class UserLabelDatabaseConnector extends DatabaseModelConnector<Label, User> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "userId";

  @override
  String get connectedTableName => "users";

  @override
  String get tableName => "userLabels";

  @override
  Future<List<Label>> getItems(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN events ON labelId = labels.id',
      limit: limit,
      offset: offset,
      where: '$connectedIdName = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => Label.fromDatabase(e)).toList() ?? [];
  }

  @override
  Future<List<User>> getConnected(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN users ON userId = users.id',
      limit: limit,
      offset: offset,
      where: '$itemIdName = ?',
      whereArgs: [connectId],
    );
    return result?.map((e) => User.fromDatabase(e)).toList() ?? [];
  }

  @override
  String get itemIdName => 'labelId';

  @override
  String get itemTableName => 'labels';
}
