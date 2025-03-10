import 'dart:typed_data';

import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/services/database.dart';

class GroupLabelDatabaseConnector extends DatabaseModelConnector<Label, Group> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupLabels";

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
  Future<List<Group>> getConnected(Uint8List connectId,
      {int offset = 0, int limit = 50}) async {
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
  String get itemIdName => 'labelId';

  @override
  String get itemTableName => 'labels';
}
