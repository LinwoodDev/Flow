import 'package:shared/models/cached.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/note/model.dart';

class ICalConverter {
  CachedData? data;

  void read(List<String> lines, [String name = '']) {
    final offset =
        lines.indexWhere((element) => element.trim() == 'BEGIN:VCALENDAR');
    if (offset == -1) {
      return;
    }
    CalendarItem? currentItem;
    Note? currentNote;
    final appointments = List<CalendarItem>.from(data?.items ?? []);
    var currentEvent = Event(name: name);
    final notes = List<Note>.from(data?.notes ?? []);
    for (int i = offset; i < lines.length; i++) {
      final line = lines[i];
      final parts = line.split(':');
      final name = parts[0].trim().split(';');
      final key = name.first;
      final value = parts.sublist(1).join(':').trim();
      if (currentItem != null) {
        switch (key) {
          case 'SUMMARY':
            currentItem = currentItem.copyWith(name: value);
            break;
          case 'DESCRIPTION':
            currentItem = currentItem.copyWith(description: value);
            break;
          case 'DTSTART':
            currentItem = currentItem.copyWith(
                start:
                    DateTime.parse(value).subtract(const Duration(minutes: 1)));
            break;
          case 'DTEND':
            currentItem = currentItem.copyWith(end: DateTime.parse(value));
            break;
          case 'END':
            if (value != 'VEVENT') break;
            appointments.add(currentItem);
            currentItem = null;
            break;
        }
      } else if (currentNote != null) {
        switch (key) {
          case 'SUMMARY':
            currentNote = currentNote.copyWith(name: value);
            break;
          case 'END':
            if (value != 'VTODO') break;
            notes.add(currentNote);
            currentNote = null;
            break;
        }
      } else {
        switch (key) {
          case 'SUMMARY':
          case 'X-WR-CALNAME':
            currentEvent = currentEvent.copyWith(name: value);
            break;
          case 'BEGIN':
            if (value == 'VEVENT') {
              currentItem = CalendarItem.fixed(
                id: appointments.length + 1,
                eventId: currentEvent.id,
              );
            } else if (value == 'VTODO') {
              currentNote = Note();
            }
            continue;
          case 'END':
            if (value == 'VCALENDAR') {
              data = CachedData(
                events: [currentEvent],
                notes: notes,
              );
              return;
            }
            continue;
        }
      }
    }
  }

  List<String> write() {
    final lines = <String>[];
    lines.add('BEGIN:VCALENDAR');
    lines.add('VERSION:2.0');
    for (final item in data?.items ?? <CalendarItem>[]) {
      lines.add('BEGIN:VEVENT');
      lines.add('SUMMARY:${item.name}');
      lines.add('DESCRIPTION:${item.description}');
      if (item.start != null) {
        lines.add('DTSTART:${item.start!.toUtc().toIso8601String()}');
      }
      if (item.end != null) {
        lines.add('DTEND:${item.end!.toUtc().toIso8601String()}');
      }
      lines.add('END:VEVENT');
    }
    for (final note in data?.notes ?? []) {
      lines.add('BEGIN:VTODO');
      lines.add('SUMMARY:${note.name}');
      lines.add('END:VTODO');
    }
    lines.add('END:VCALENDAR');
    return lines;
  }
}
