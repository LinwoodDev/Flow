import 'package:shared/models/event/item/model.dart';

import 'package:shared/models/note/database.dart';

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
