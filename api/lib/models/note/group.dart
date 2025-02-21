import 'package:flow_api/models/note/database.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:sqflite_common/sqlite_api.dart';

class GroupNoteDatabaseConnector extends NoteDatabaseConnector<Group> {
  @override
  String get connectedIdName => "groupId";

  @override
  String get connectedTableName => "groups";

  @override
  String get tableName => "groupNotes";

  @override
  Group decode(Map<String, dynamic> data) => Group.fromDatabase(data);

  @override
  Future<void> migrate(Database db, int version) async {
    if (version < 4) {
      await create(db);
    }
  }
}
