import 'package:flow_api/models/cached.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/services/database.dart';

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

  EventStatus _parseEventStatus(String value) {
    switch (value.toUpperCase()) {
      case 'TENTATIVE':
        return EventStatus.draft;
      case 'CANCELLED':
        return EventStatus.cancelled;
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
    'SUMMARY:${item.name}',
    'DESCRIPTION:${item.description}',
    if (item.location.isNotEmpty) 'LOCATION:${item.location}',
    if (item.start != null) 'DTSTART:${_formatDateTime(item.start!.toUtc())}',
    if (item.end != null) 'DTEND:${_formatDateTime(item.end!.toUtc())}',
    'STATUS:${_formatEventStatus(item.status)}',
    'END:VEVENT',
  ];

  String _formatDateTime(DateTime dateTime) =>
      "${dateTime.year}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}00Z";

  String _formatEventStatus(EventStatus status) {
    switch (status) {
      case EventStatus.draft:
        return 'TENTATIVE';
      case EventStatus.cancelled:
        return 'CANCELLED';
      case EventStatus.confirmed:
        return 'CONFIRMED';
    }
  }

  List<String> writeNote(Note note) => [
    'BEGIN:VTODO',
    'SUMMARY:${note.name}',
    'DESCRIPTION:${note.description}',
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
      lines.add('NAME:${event.name}');
      lines.add('X-WR-CALNAME:${event.name}');
    }
    lines.addAll(data?.items.expand(writeEvent) ?? []);
    lines.addAll(data?.notes.expand(writeNote) ?? []);
    lines.add('END:VCALENDAR');
    return lines;
  }
}
