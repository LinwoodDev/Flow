import 'dart:async';
import 'dart:typed_data';

import '../../../services/source.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';

abstract class CalendarItemService extends ModelService {
  FutureOr<CalendarItem?> getCalendarItem(Uint8List id);
  FutureOr<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Uint8List? eventId,
    Uint8List? groupId,
    List<Uint8List>? resourceIds,
    bool pending = false,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  });

  FutureOr<CalendarItem?> createCalendarItem(CalendarItem item);

  FutureOr<bool> updateCalendarItem(CalendarItem item);

  FutureOr<bool> deleteCalendarItem(Uint8List id);
}

abstract class CalendarItemResourceConnector<T> extends ModelService {
  FutureOr<void> connect(Uint8List calendarItemId, Uint8List resourceId);
  FutureOr<void> disconnect(Uint8List calendarItemId, Uint8List resourceId);
  FutureOr<bool> isConnected(Uint8List calendarItemId, Uint8List resourceId);
}
