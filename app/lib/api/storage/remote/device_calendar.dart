import 'dart:convert';
import 'dart:typed_data';

import 'package:device_calendar_plus/device_calendar_plus.dart' as native;
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/item/service.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/event/service.dart';
import 'package:flow_api/models/model.dart';

import 'model.dart';
import 'service.dart';

abstract interface class DeviceCalendarGateway {
  Future<List<native.Calendar>> listCalendars();

  Future<String> createCalendar(String name);

  Future<void> updateCalendar(String id, String name);

  Future<void> deleteCalendar(String id);

  Future<List<native.Event>> listEvents(
    DateTime start,
    DateTime end, {
    List<String>? calendarIds,
  });

  Future<native.Event?> getEvent(String id);

  Future<String> createEvent({
    String? calendarId,
    required String title,
    required DateTime start,
    required DateTime end,
    required bool isAllDay,
    String? description,
    String? location,
    native.RecurrenceRule? recurrenceRule,
  });

  Future<void> updateEvent({
    required String id,
    required String title,
    required DateTime start,
    required DateTime end,
    required bool isAllDay,
    required String description,
    required String location,
    native.RecurrenceRule? recurrenceRule,
  });

  Future<void> deleteEvent(String id);
}

final class PluginDeviceCalendarGateway implements DeviceCalendarGateway {
  final native.DeviceCalendar plugin;

  PluginDeviceCalendarGateway([native.DeviceCalendar? plugin])
    : plugin = plugin ?? native.DeviceCalendar.instance;

  @override
  Future<List<native.Calendar>> listCalendars() => plugin.listCalendars();

  @override
  Future<String> createCalendar(String name) =>
      plugin.createCalendar(name: name);

  @override
  Future<void> updateCalendar(String id, String name) =>
      plugin.updateCalendar(id, name: name);

  @override
  Future<void> deleteCalendar(String id) => plugin.deleteCalendar(id);

  @override
  Future<List<native.Event>> listEvents(
    DateTime start,
    DateTime end, {
    List<String>? calendarIds,
  }) => plugin.listEvents(start, end, calendarIds: calendarIds);

  @override
  Future<native.Event?> getEvent(String id) => plugin.getEvent(id);

  @override
  Future<String> createEvent({
    String? calendarId,
    required String title,
    required DateTime start,
    required DateTime end,
    required bool isAllDay,
    String? description,
    String? location,
    native.RecurrenceRule? recurrenceRule,
  }) => plugin.createEvent(
    calendarId: calendarId,
    title: title,
    startDate: start,
    endDate: end,
    isAllDay: isAllDay,
    description: description,
    location: location,
    recurrenceRule: recurrenceRule,
  );

  @override
  Future<void> updateEvent({
    required String id,
    required String title,
    required DateTime start,
    required DateTime end,
    required bool isAllDay,
    required String description,
    required String location,
    native.RecurrenceRule? recurrenceRule,
  }) {
    final descriptionPatch = description.isEmpty
        ? const native.Patch<String>.clear()
        : native.Patch<String>.set(description);
    final locationPatch = location.isEmpty
        ? const native.Patch<String>.clear()
        : native.Patch<String>.set(location);
    if (recurrenceRule != null) {
      return plugin.updateRecurring(
        id,
        native.EventSpan.allEvents,
        title: title,
        start: start,
        duration: end.difference(start),
        isAllDay: isAllDay,
        description: descriptionPatch,
        location: locationPatch,
        recurrenceRule: native.Patch.set(recurrenceRule),
      );
    }
    return plugin.updateEvent(
      eventId: id,
      title: title,
      startDate: start,
      endDate: end,
      isAllDay: isAllDay,
      description: descriptionPatch,
      location: locationPatch,
    );
  }

  @override
  Future<void> deleteEvent(String id) => plugin.deleteEvent(eventId: id);
}

final class DeviceCalendarRemoteService
    extends RemoteService<DeviceCalendarStorage> {
  final DeviceCalendarGateway gateway;

  @override
  late final DeviceCalendarEventService event;
  @override
  late final DeviceCalendarItemService calendarItem;

  DeviceCalendarRemoteService(
    super.remoteStorage,
    super.local,
    super.password, {
    DeviceCalendarGateway? gateway,
  }) : gateway = gateway ?? PluginDeviceCalendarGateway() {
    event = DeviceCalendarEventService(
      this.gateway,
      calendarIds: remoteStorage.calendarIds,
    );
    calendarItem = DeviceCalendarItemService(
      this.gateway,
      calendarIds: remoteStorage.calendarIds,
    );
  }
}

final class DeviceCalendarEventService extends EventService {
  final DeviceCalendarGateway gateway;
  final Set<String> calendarIds;

  DeviceCalendarEventService(
    this.gateway, {
    Iterable<String> calendarIds = const [],
  }) : calendarIds = Set.unmodifiable(calendarIds);

  bool _includesCalendar(String id) =>
      calendarIds.isEmpty || calendarIds.contains(id);

  @override
  Future<void> clear() async {}

  @override
  Future<Event?> getEvent(Uint8List id) async {
    final calendarId = _decodeId(id);
    if (!_includesCalendar(calendarId)) return null;
    final calendars = await gateway.listCalendars();
    return calendars
        .where((calendar) => calendar.id == calendarId)
        .map(_calendarToEvent)
        .firstOrNull;
  }

  @override
  Future<List<Event>> getEvents({
    Uint8List? groupId,
    int offset = 0,
    int limit = 50,
    String search = '',
    List<Uint8List>? resourceIds,
  }) async {
    if (groupId != null || (resourceIds?.isNotEmpty ?? false)) return [];
    final query = search.toLowerCase();
    final calendars = await gateway.listCalendars();
    return calendars
        .where((calendar) => _includesCalendar(calendar.id))
        .where((calendar) => !calendar.hidden)
        .where(
          (calendar) =>
              query.isEmpty ||
              calendar.name.toLowerCase().contains(query) ||
              (calendar.accountName?.toLowerCase().contains(query) ?? false),
        )
        .skip(offset)
        .take(limit)
        .map(_calendarToEvent)
        .toList();
  }

  @override
  Future<Event?> createEvent(Event event) async {
    if (calendarIds.isNotEmpty) return null;
    final id = await gateway.createCalendar(event.name);
    return event.copyWith(id: _encodeId(id));
  }

  @override
  Future<bool> updateEvent(Event event) async {
    final id = event.id;
    if (id == null) return false;
    final calendarId = _decodeId(id);
    if (!_includesCalendar(calendarId)) return false;
    await gateway.updateCalendar(calendarId, event.name);
    return true;
  }

  @override
  Future<bool> deleteEvent(Uint8List id) async {
    final calendarId = _decodeId(id);
    if (!_includesCalendar(calendarId)) return false;
    await gateway.deleteCalendar(calendarId);
    return true;
  }
}

final class DeviceCalendarItemService extends CalendarItemService {
  final DeviceCalendarGateway gateway;
  final Set<String> calendarIds;

  DeviceCalendarItemService(
    this.gateway, {
    Iterable<String> calendarIds = const [],
  }) : calendarIds = Set.unmodifiable(calendarIds);

  bool _includesCalendar(String id) =>
      calendarIds.isEmpty || calendarIds.contains(id);

  @override
  Future<void> clear() async {}

  @override
  Future<CalendarItem?> getCalendarItem(Uint8List id) async {
    final event = await gateway.getEvent(_decodeId(id));
    return event == null || !_includesCalendar(event.calendarId)
        ? null
        : _nativeToItem(event);
  }

  @override
  Future<List<ConnectedModel<CalendarItem, Event?>>> getCalendarItems({
    List<EventStatus>? status,
    Uint8List? eventId,
    List<Uint8List>? groupIds,
    List<Uint8List>? resourceIds,
    bool pending = false,
    int offset = 0,
    int limit = 50,
    DateTime? start,
    DateTime? end,
    DateTime? date,
    String search = '',
  }) async {
    if (pending ||
        (groupIds?.isNotEmpty ?? false) ||
        (resourceIds?.isNotEmpty ?? false)) {
      return [];
    }

    final rangeStart = date == null
        ? (start ?? DateTime.now().subtract(const Duration(days: 730)))
        : DateTime(date.year, date.month, date.day);
    final rangeEnd = date == null
        ? (end ?? DateTime.now().add(const Duration(days: 730)))
        : rangeStart.add(const Duration(days: 1));
    final requestedCalendarId = eventId == null ? null : _decodeId(eventId);
    if (requestedCalendarId != null &&
        !_includesCalendar(requestedCalendarId)) {
      return [];
    }
    final requestedCalendarIds = requestedCalendarId != null
        ? [requestedCalendarId]
        : calendarIds.isEmpty
        ? null
        : calendarIds.toList(growable: false);
    final events = await gateway.listEvents(
      rangeStart,
      rangeEnd,
      calendarIds: requestedCalendarIds,
    );
    final calendars = {
      for (final calendar in await gateway.listCalendars())
        if (_includesCalendar(calendar.id))
          calendar.id: _calendarToEvent(calendar),
    };
    final query = search.toLowerCase();
    return events
        .where((event) => _includesCalendar(event.calendarId))
        .where(
          (event) => status?.contains(_statusFromNative(event.status)) ?? true,
        )
        .where(
          (event) =>
              query.isEmpty ||
              event.title.toLowerCase().contains(query) ||
              (event.description?.toLowerCase().contains(query) ?? false) ||
              (event.location?.toLowerCase().contains(query) ?? false),
        )
        .skip(offset)
        .take(limit)
        .map(
          (event) => ConnectedModel<CalendarItem, Event?>(
            _nativeToItem(event),
            calendars[event.calendarId],
          ),
        )
        .toList();
  }

  @override
  Future<CalendarItem?> createCalendarItem(CalendarItem item) async {
    final dates = _nativeDates(item);
    if (dates == null) return null;
    final explicitCalendarId = item.eventId == null
        ? null
        : _decodeId(item.eventId!);
    if (explicitCalendarId != null && !_includesCalendar(explicitCalendarId)) {
      return null;
    }
    final targetCalendarId =
        explicitCalendarId ??
        (calendarIds.length == 1 ? calendarIds.single : null);
    if (calendarIds.isNotEmpty && targetCalendarId == null) return null;
    final id = await gateway.createEvent(
      calendarId: targetCalendarId,
      title: item.name,
      start: dates.$1,
      end: dates.$2,
      isAllDay: dates.$3,
      description: item.description.isEmpty ? null : item.description,
      location: item.location.isEmpty ? null : item.location,
      recurrenceRule: _recurrenceToNative(item),
    );
    final created = await gateway.getEvent(id);
    return created == null
        ? item.copyWith(id: _encodeId(id))
        : _nativeToItem(created);
  }

  @override
  Future<bool> updateCalendarItem(CalendarItem item) async {
    final id = item.id;
    final dates = _nativeDates(item);
    if (id == null || dates == null) return false;
    if (item.eventId != null && !_includesCalendar(_decodeId(item.eventId!))) {
      return false;
    }
    if (calendarIds.isNotEmpty) {
      final existing = await gateway.getEvent(_decodeId(id));
      if (existing == null || !_includesCalendar(existing.calendarId)) {
        return false;
      }
    }
    await gateway.updateEvent(
      id: _decodeId(id),
      title: item.name,
      start: dates.$1,
      end: dates.$2,
      isAllDay: dates.$3,
      description: item.description,
      location: item.location,
      recurrenceRule: _recurrenceToNative(item),
    );
    return true;
  }

  @override
  Future<bool> deleteCalendarItem(Uint8List id) async {
    final nativeId = _decodeId(id);
    if (calendarIds.isNotEmpty) {
      final existing = await gateway.getEvent(nativeId);
      if (existing == null || !_includesCalendar(existing.calendarId)) {
        return false;
      }
    }
    await gateway.deleteEvent(nativeId);
    return true;
  }
}

Event _calendarToEvent(native.Calendar calendar) => Event(
  id: _encodeId(calendar.id),
  name: calendar.name,
  description: calendar.accountName ?? '',
  blocked: true,
);

CalendarItem _nativeToItem(native.Event event) {
  final end =
      event.isAllDay &&
          event.endDate.hour == 0 &&
          event.endDate.minute == 0 &&
          event.endDate.isAfter(event.startDate)
      ? event.endDate.subtract(const Duration(minutes: 1))
      : event.endDate;
  final values = (
    id: _encodeId(event.instanceId),
    name: event.title,
    description: event.description ?? '',
    location: event.location ?? '',
    eventId: _encodeId(event.calendarId),
    start: event.startDate,
    end: end,
    status: _statusFromNative(event.status),
  );
  final recurrence = event.recurrenceRule;
  if (!event.isRecurring || recurrence == null) {
    return FixedCalendarItem(
      id: values.id,
      name: values.name,
      description: values.description,
      location: values.location,
      eventId: values.eventId,
      start: values.start,
      end: values.end,
      status: values.status,
    );
  }
  final endCondition = recurrence.end;
  final count = endCondition is native.CountEnd ? endCondition.count : 0;
  final until = endCondition is native.UntilEnd ? endCondition.until : null;
  final repeatType = switch (recurrence) {
    native.DailyRecurrence() => RepeatType.daily,
    native.WeeklyRecurrence() => RepeatType.weekly,
    native.MonthlyRecurrence() => RepeatType.monthly,
    native.YearlyRecurrence() => RepeatType.yearly,
  };
  final variation = switch (recurrence) {
    native.WeeklyRecurrence(:final daysOfWeek) =>
      RepeatingCalendarItem.encodeWeeklyWeekdays(
        (daysOfWeek ?? const <native.DayOfWeek>[]).map(
          (day) => day.index + DateTime.monday,
        ),
      ),
    native.MonthlyByDate(:final daysOfMonth) =>
      RepeatingCalendarItem.encodeMonthlyMonthDays(daysOfMonth ?? const []),
    _ => 0,
  };
  return RepeatingCalendarItem(
    id: values.id,
    name: values.name,
    description: values.description,
    location: values.location,
    eventId: values.eventId,
    start: values.start,
    end: values.end,
    status: values.status,
    repeatType: repeatType,
    interval: recurrence.interval,
    variation: variation,
    count: count,
    until: until,
  );
}

(DateTime, DateTime, bool)? _nativeDates(CalendarItem item) {
  final start = item.start;
  final end = item.end;
  if (start == null || end == null) return null;
  final isAllDay =
      start.hour == 0 &&
      start.minute == 0 &&
      end.hour == 23 &&
      end.minute == 59;
  final nativeEnd = isAllDay
      ? DateTime(end.year, end.month, end.day).add(const Duration(days: 1))
      : end == start
      ? end.add(const Duration(minutes: 1))
      : end;
  return (start, nativeEnd, isAllDay);
}

native.RecurrenceRule? _recurrenceToNative(CalendarItem item) {
  if (item is! RepeatingCalendarItem) return null;
  final end = item.count > 0
      ? native.CountEnd(item.count)
      : item.until == null
      ? null
      : native.UntilEnd(item.until!);
  return switch (item.repeatType) {
    RepeatType.daily => native.DailyRecurrence(
      interval: item.interval,
      end: end,
    ),
    RepeatType.weekly => native.WeeklyRecurrence(
      interval: item.interval,
      end: end,
      daysOfWeek: item.weeklyWeekdays
          .map((weekday) => native.DayOfWeek.values[weekday - 1])
          .toList(),
    ),
    RepeatType.monthly => native.MonthlyRecurrence(
      interval: item.interval,
      end: end,
      daysOfMonth: item.monthlyMonthDays,
    ),
    RepeatType.yearly => native.YearlyRecurrence(
      interval: item.interval,
      end: end,
      months: item.start == null ? null : [item.start!.month],
      daysOfMonth: item.start == null ? null : [item.start!.day],
    ),
  };
}

EventStatus _statusFromNative(native.EventStatus status) => switch (status) {
  native.EventStatus.tentative => EventStatus.draft,
  native.EventStatus.canceled => EventStatus.cancelled,
  native.EventStatus.none ||
  native.EventStatus.confirmed => EventStatus.confirmed,
};

Uint8List _encodeId(String id) => Uint8List.fromList(utf8.encode(id));

String _decodeId(Uint8List id) => utf8.decode(id);
