import 'package:shared/models/event/moment/model.dart';

import 'package:shared/models/note/database.dart';

class MomentNoteDatabaseConnector extends NoteDatabaseConnector<Moment> {
  @override
  String get connectedIdName => "momentId";

  @override
  String get connectedTableName => "moments";

  @override
  String get tableName => "momentNotes";
}
