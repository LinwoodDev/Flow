import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/resource/database.dart';

class EventResourceDatabaseConnector extends ResourceDatabaseConnector<Event> {
  @override
  String get connectedIdName => "eventId";

  @override
  String get connectedTableName => "events";

  @override
  String get tableName => "eventResources";

  @override
  Event decode(Map<String, dynamic> data) => Event.fromDatabase(data);
}
