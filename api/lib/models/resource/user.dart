import 'package:flow_api/models/resource/database.dart';
import 'package:flow_api/models/user/model.dart';

class UserResourceDatabaseConnector extends ResourceDatabaseConnector<User> {
  @override
  bool get usesPermission => true;
  @override
  String get connectedIdName => "userId";

  @override
  String get connectedTableName => "users";

  @override
  String get tableName => "userResources";

  @override
  User decode(Map<String, dynamic> data) => User.fromDatabase(data);
}
