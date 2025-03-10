import 'dart:typed_data';

import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/services/database.dart';

class GroupNoteDatabaseConnector extends NoteDatabaseConnector<Group> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupNotes";

  @override
  Group decode(Map<String, dynamic> data) => Group.fromDatabase(data);
}

class GroupNotebookDatabaseConnector
    extends DatabaseModelConnector<Notebook, Group> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupNotebooks";

  @override
  Future<List<Notebook>> getItems(Uint8List itemId,
      {int offset = 0, int limit = 50}) async {
    final result = await db?.query(
      '$tableName JOIN events ON notebookId = notebooks.id',
      limit: limit,
      offset: offset,
      where: '$connectedIdName = ?',
      whereArgs: [itemId],
    );
    return result?.map((e) => Notebook.fromDatabase(e)).toList() ?? [];
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
  String get itemIdName => 'notebookId';

  @override
  String get itemTableName => 'notebooks';
}
