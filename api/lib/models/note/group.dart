import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/group/model.dart';

class GroupNoteDatabaseConnector extends NoteDatabaseConnector<Group> {
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupNotes";

  @override
  Group decode(Map<String, dynamic> data) => Group.fromDatabase(data);
}
