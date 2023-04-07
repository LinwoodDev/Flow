import 'package:shared/models/event/item/model.dart';

import 'package:shared/models/note/database.dart';

class CalendarItemNoteDatabaseConnector
    extends NoteDatabaseConnector<CalendarItem> {
  @override
  String get connectedIdName => "itemId";

  @override
  String get connectedTableName => "items";

  @override
  String get tableName => "itemNotes";
}
