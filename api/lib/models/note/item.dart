import 'package:flow_api/models/event/item/model.dart';

import 'package:flow_api/models/note/database.dart';

class CalendarItemNoteDatabaseConnector
    extends NoteDatabaseConnector<CalendarItem> {
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "calendarItems";

  @override
  String get tableName => "calendarItemNotes";

  @override
  CalendarItem decode(Map<String, dynamic> data) =>
      CalendarItem.fromDatabase(data);
}
