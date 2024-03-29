import 'package:flow_api/models/note/database.dart';

import '../event/model.dart';

class EventNoteDatabaseConnector extends NoteDatabaseConnector<Event> {
  @override
  String get connectedIdName => "eventId";

  @override
  String get connectedTableName => "events";

  @override
  String get tableName => "eventNotes";

  @override
  Event decode(Map<String, dynamic> data) => Event.fromDatabase(data);
}
