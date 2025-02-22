import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/user/model.dart';

class UserNoteDatabaseConnector extends NoteDatabaseConnector<User> {
  @override
  String get connectedIdName => "userId";

  @override
  String get connectedTableName => "users";

  @override
  String get tableName => "userNotes";

  @override
  User decode(Map<String, dynamic> data) => User.fromDatabase(data);
}
