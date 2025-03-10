import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/resource/database.dart';

class GroupResourceDatabaseConnector extends ResourceDatabaseConnector<Group> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupResources";

  @override
  Group decode(Map<String, dynamic> data) => Group.fromDatabase(data);
}
