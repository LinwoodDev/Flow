import 'dart:async';

import 'package:lib5/lib5.dart';

import '../../../services/source.dart';
import '../../model.dart';
import '../model.dart';
import 'model.dart';

abstract class CalendarItemService extends ModelService {
  FutureOr<CalendarItem?> getCalendarItem(Multihash id);
  FutureOr<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Multihash? eventId,
    Multihash? groupId,
    Multihash? placeId,
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

  FutureOr<bool> deleteCalendarItem(Multihash id);
}
