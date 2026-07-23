import 'package:dart_leap/dart_leap.dart';
import 'package:flow_api/models/cached.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/services/database.dart';

class _RRule {
  final RepeatType repeatType;
  final int interval;
  final int count;
  final DateTime? until;
  final List<int> byWeekDays;
  final List<int> byMonthDays;

  _RRule(
    this.repeatType,
    this.interval,
    this.count,
    this.until, {
    this.byWeekDays = const [],
    this.byMonthDays = const [],
  });
}

class ICalConverter {
  CachedData? data;

  ICalConverter([this.data]);

  void read(List<String> lines, {Event? event, Notebook? notebook}) {
    final unfoldedLines = <String>[];
    for (final line in lines) {
      if (line.isEmpty) continue;
      if (line.startsWith(' ') || line.startsWith('\t')) {
        if (unfoldedLines.isNotEmpty) {
          unfoldedLines.last += line.substring(1);
        }
      } else {
        unfoldedLines.add(line.trim());
      }
    }

    CalendarItem? currentItem;
    Note? currentNote;
    final items = List<CalendarItem>.from(data?.items ?? []);
    var currentEvent = event ?? Event(id: createUniqueUint8List());
    var currentNotebook = notebook ?? Notebook(id: createUniqueUint8List());
    final notes = List<Note>.from(data?.notes ?? []);

    for (final line in unfoldedLines) {
      final parts = line.split(':');
      if (parts.length < 2) continue;

      final keyPart = parts[0];
      var value = parts.sublist(1).join(':');

      final keyParts = keyPart.split(';');
      final key = keyParts[0].toUpperCase().trim();

      value = _unescape(value);

      if (key == 'BEGIN') {
        if (value == 'VEVENT') {
          currentItem = FixedCalendarItem(eventId: currentEvent.id);
        } else if (value == 'VTODO') {
          currentNote = Note(notebookId: currentNotebook.id!);
        }
      } else if (key == 'END') {
        if (value == 'VEVENT' && currentItem != null) {
          items.add(currentItem);
          currentItem = null;
        } else if (value == 'VTODO' && currentNote != null) {
          notes.add(currentNote);
          currentNote = null;
        }
      } else if (currentItem != null) {
        switch (key) {
          case 'SUMMARY':
            currentItem = currentItem.copyWith(name: value);
            break;
          case 'DESCRIPTION':
            currentItem = currentItem.copyWith(description: value);
            break;
          case 'LOCATION':
            currentItem = currentItem.copyWith(location: value);
            break;
          case 'DTSTART':
            currentItem = currentItem.copyWith(start: _parseDateTime(value));
            break;
          case 'DTEND':
            currentItem = currentItem.copyWith(end: _parseDateTime(value));
            break;
          case 'STATUS':
            currentItem = currentItem.copyWith(
              status: _parseEventStatus(value),
            );
            break;
          case 'RRULE':
            final rrule = _parseRRule(value);
            if (rrule != null) {
              currentItem = _copyWithRRule(currentItem, rrule);
            }
            break;
          case 'EXDATE':
            currentItem = _copyWithExceptions(currentItem, [
              ..._repeatingExceptions(currentItem),
              ..._parseDateTimes(value).map((e) => e.secondsSinceEpoch),
            ]);
            break;
        }
      } else if (currentNote != null) {
        switch (key) {
          case 'SUMMARY':
            currentNote = currentNote.copyWith(name: value);
            break;
          case 'DESCRIPTION':
            currentNote = currentNote.copyWith(description: value);
            break;
          case 'STATUS':
            currentNote = currentNote.copyWith(status: _parseNoteStatus(value));
            break;
          case 'PRIORITY':
            currentNote = currentNote.copyWith(
              priority: int.tryParse(value) ?? 0,
            );
            break;
        }
      } else {
        switch (key) {
          case 'NAME':
          case 'X-WR-CALNAME':
            currentEvent = currentEvent.copyWith(name: value);
            currentNotebook = currentNotebook.copyWith(name: value);
            break;
        }
      }
    }

    var current = CachedData(
      events: [currentEvent],
      items: items,
      notes: notes,
      notebooks: [currentNotebook],
    );
    if (data == null) {
      data = current;
    } else {
      data = data!.concat(current);
    }
  }

  String _unescape(String value) {
    return value.replaceAllMapped(RegExp(r'\\[,;\\nN]'), (match) {
      final s = match.group(0)!;
      switch (s.toLowerCase()) {
        case r'\,':
          return ',';
        case r'\;':
          return ';';
        case r'\\':
          return r'\';
        case r'\n':
          return '\n';
        default:
          return s;
      }
    });
  }

  String _escape(String value) {
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll(';', r'\;')
        .replaceAll(',', r'\,')
        .replaceAll('\n', r'\n');
  }

  DateTime? _parseDateTime(String value) {
    if (value.length == 8) {
      return DateTime.tryParse(
        "${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}",
      );
    } else if (value.length >= 15) {
      if (value[8] == 'T') {
        var iso =
            "${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}T${value.substring(9, 11)}:${value.substring(11, 13)}:${value.substring(13, 15)}";
        if (value.endsWith('Z')) {
          iso += 'Z';
        }
        return DateTime.tryParse(iso);
      }
    }
    return DateTime.tryParse(value);
  }

  List<DateTime> _parseDateTimes(String value) =>
      value.split(',').map((e) => _parseDateTime(e.trim())).nonNulls.toList();

  List<int> _repeatingExceptions(CalendarItem? item) =>
      item is RepeatingCalendarItem ? item.exceptions : const [];

  CalendarItem _copyWithRRule(CalendarItem item, _RRule rrule) {
    final exceptions = _repeatingExceptions(item);
    return RepeatingCalendarItem(
      id: item.id,
      name: item.name,
      description: item.description,
      location: item.location,
      eventId: item.eventId,
      start: item.start,
      end: item.end,
      status: item.status,
      repeatType: rrule.repeatType,
      interval: rrule.interval,
      variation: _variationFromRRule(rrule),
      count: rrule.count,
      until: rrule.until,
      exceptions: exceptions,
    );
  }

  CalendarItem _copyWithExceptions(CalendarItem item, List<int> exceptions) {
    final distinctExceptions = exceptions.toSet().toList()..sort();
    if (item is RepeatingCalendarItem) {
      return item.copyWith(exceptions: distinctExceptions);
    }
    return RepeatingCalendarItem(
      id: item.id,
      name: item.name,
      description: item.description,
      location: item.location,
      eventId: item.eventId,
      start: item.start,
      end: item.end,
      status: item.status,
      exceptions: distinctExceptions,
    );
  }

  _RRule? _parseRRule(String value) {
    var type = RepeatType.daily;
    int interval = 1;
    int count = 0;
    DateTime? until;
    var byWeekDays = <int>[];
    var byMonthDays = <int>[];

    final parts = value.split(';');
    for (final part in parts) {
      final kv = part.split('=');
      if (kv.length != 2) continue;
      final k = kv[0].toUpperCase();
      final v = kv[1];
      if (k == 'FREQ') {
        type = switch (v.toUpperCase()) {
          'DAILY' => RepeatType.daily,
          'WEEKLY' => RepeatType.weekly,
          'MONTHLY' => RepeatType.monthly,
          'YEARLY' => RepeatType.yearly,
          _ => type,
        };
      } else if (k == 'INTERVAL') {
        interval = int.tryParse(v) ?? 1;
      } else if (k == 'COUNT') {
        count = int.tryParse(v) ?? 0;
      } else if (k == 'UNTIL') {
        until = _parseDateTime(v);
      } else if (k == 'BYDAY') {
        byWeekDays = _parseByDay(v);
      } else if (k == 'BYMONTHDAY') {
        byMonthDays = _parseByMonthDay(v);
      }
    }
    return _RRule(
      type,
      interval,
      count,
      until,
      byWeekDays: byWeekDays,
      byMonthDays: byMonthDays,
    );
  }

  int _variationFromRRule(_RRule rule) {
    switch (rule.repeatType) {
      case RepeatType.weekly:
        return RepeatingCalendarItem.encodeWeeklyWeekdays(rule.byWeekDays);
      case RepeatType.monthly:
        return RepeatingCalendarItem.encodeMonthlyMonthDays(rule.byMonthDays);
      case RepeatType.daily:
      case RepeatType.yearly:
        return 0;
    }
  }

  List<int> _parseByDay(String value) {
    final weekdays = <int>[];
    for (final part in value.split(',')) {
      final token = part.trim().toUpperCase();
      if (token.length < 2) continue;
      final dayCode = token.substring(token.length - 2);
      final weekday = _weekdayFromIcs(dayCode);
      if (weekday != null) {
        weekdays.add(weekday);
      }
    }
    return weekdays;
  }

  List<int> _parseByMonthDay(String value) {
    final days = <int>[];
    for (final part in value.split(',')) {
      final day = int.tryParse(part.trim());
      if (day != null && day >= 1 && day <= 31) {
        days.add(day);
      }
    }
    return days;
  }

  int? _weekdayFromIcs(String day) {
    return switch (day) {
      'MO' => DateTime.monday,
      'TU' => DateTime.tuesday,
      'WE' => DateTime.wednesday,
      'TH' => DateTime.thursday,
      'FR' => DateTime.friday,
      'SA' => DateTime.saturday,
      'SU' => DateTime.sunday,
      _ => null,
    };
  }

  EventStatus _parseEventStatus(String value) {
    switch (value.toUpperCase()) {
      case 'TENTATIVE':
        return EventStatus.draft;
      case 'CANCELLED':
        return EventStatus.cancelled;
      case 'COMPLETED':
        return EventStatus.completed;
      case 'CONFIRMED':
      default:
        return EventStatus.confirmed;
    }
  }

  NoteStatus _parseNoteStatus(String value) {
    switch (value.toUpperCase()) {
      case 'COMPLETED':
        return NoteStatus.done;
      case 'IN-PROCESS':
        return NoteStatus.inProgress;
      case 'NEEDS-ACTION':
      default:
        return NoteStatus.todo;
    }
  }

  List<String> writeEvent(CalendarItem item) => [
    'BEGIN:VEVENT',
    'SUMMARY:${_escape(item.name)}',
    'DESCRIPTION:${_escape(item.description)}',
    if (item.location.isNotEmpty) 'LOCATION:${_escape(item.location)}',
    if (item.start != null) 'DTSTART:${_formatDateTime(item.start!.toUtc())}',
    if (item.end != null) 'DTEND:${_formatDateTime(item.end!.toUtc())}',
    if (item is RepeatingCalendarItem) _formatRRule(item),
    if (item is RepeatingCalendarItem && item.exceptions.isNotEmpty)
      'EXDATE:${item.exceptions.map(_formatException).join(',')}',
    'STATUS:${_formatEventStatus(item.status)}',
    'END:VEVENT',
  ];

  String _formatRRule(RepeatingCalendarItem item) {
    final parts = <String>['FREQ=${_formatRepeatType(item.repeatType)}'];
    if (item.interval > 1) {
      parts.add('INTERVAL=${item.interval}');
    }
    if (item.count > 0) {
      parts.add('COUNT=${item.count}');
    }
    if (item.until != null) {
      parts.add('UNTIL=${_formatDateTime(item.until!.toUtc())}');
    }
    if (item.repeatType == RepeatType.weekly) {
      final weekdays = item.weeklyVariationWeekdays;
      if (weekdays.isNotEmpty) {
        parts.add('BYDAY=${weekdays.map(_weekdayToIcs).join(',')}');
      }
    } else if (item.repeatType == RepeatType.monthly) {
      final monthDays = item.monthlyVariationMonthDays;
      if (monthDays.isNotEmpty) {
        parts.add('BYMONTHDAY=${monthDays.join(',')}');
      }
    }
    return 'RRULE:${parts.join(';')}';
  }

  String _weekdayToIcs(int weekday) {
    return switch (weekday) {
      DateTime.monday => 'MO',
      DateTime.tuesday => 'TU',
      DateTime.wednesday => 'WE',
      DateTime.thursday => 'TH',
      DateTime.friday => 'FR',
      DateTime.saturday => 'SA',
      DateTime.sunday => 'SU',
      _ => 'MO',
    };
  }

  String _formatException(int secondsSinceEpoch) => _formatDateTime(
    DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000, isUtc: true),
  );

  String _formatDateTime(DateTime dateTime) =>
      "${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}${dateTime.second.toString().padLeft(2, '0')}Z";

  String _formatRepeatType(RepeatType type) {
    switch (type) {
      case RepeatType.daily:
        return 'DAILY';
      case RepeatType.weekly:
        return 'WEEKLY';
      case RepeatType.monthly:
        return 'MONTHLY';
      case RepeatType.yearly:
        return 'YEARLY';
    }
  }

  String _formatEventStatus(EventStatus status) {
    switch (status) {
      case EventStatus.draft:
        return 'TENTATIVE';
      case EventStatus.cancelled:
        return 'CANCELLED';
      case EventStatus.completed:
        return 'COMPLETED';
      case EventStatus.confirmed:
        return 'CONFIRMED';
    }
  }

  List<String> writeNote(Note note) => [
    'BEGIN:VTODO',
    'SUMMARY:${_escape(note.name)}',
    'DESCRIPTION:${_escape(note.description)}',
    'STATUS:${_formatNoteStatus(note.status)}',
    if (note.priority != 0) 'PRIORITY:${note.priority}',
    'END:VTODO',
  ];

  String _formatNoteStatus(NoteStatus? status) {
    switch (status) {
      case NoteStatus.done:
        return 'COMPLETED';
      case NoteStatus.inProgress:
        return 'IN-PROCESS';
      case NoteStatus.todo:
      default:
        return 'NEEDS-ACTION';
    }
  }

  List<String> write([Event? event]) {
    final lines = <String>[];
    lines.add('BEGIN:VCALENDAR');
    lines.add('VERSION:2.0');
    if (event != null) {
      lines.add('NAME:${_escape(event.name)}');
      lines.add('X-WR-CALNAME:${_escape(event.name)}');
    }
    lines.addAll(data?.items.expand(writeEvent) ?? []);
    lines.addAll(data?.notes.expand(writeNote) ?? []);
    lines.add('END:VCALENDAR');
    return lines;
  }
}
