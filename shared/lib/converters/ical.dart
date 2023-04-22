import 'package:shared/models/cached.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/note/model.dart';

class ICalConverter {
  CachedData? data;

  ICalConverter([this.data]);

  void read(List<String> lines, [String name = '']) {
    final offset =
        lines.indexWhere((element) => element.trim() == 'BEGIN:VCALENDAR');
    if (offset == -1) {
      return;
    }
    CalendarItem? currentItem;
    Note? currentNote;
    final items = List<CalendarItem>.from(data?.items ?? []);
    var currentEvent = Event(name: name, id: 1);
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
            items.add(currentItem);
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
                id: items.length + 1,
                eventId: currentEvent.id,
              );
            } else if (value == 'VTODO') {
              currentNote = Note();
            }
            continue;
          case 'END':
            if (value == 'VCALENDAR') {
              var current = CachedData(
                events: [currentEvent],
                items: items,
                notes: notes,
              );
              if (data == null) {
                data = current;
              } else {
                data = data!.concat(current);
              }
              return;
            }
            continue;
        }
      }
    }
  }

  List<String> writeEvent(CalendarItem item) => [
        'BEGIN:VEVENT',
        'SUMMARY:${item.name}',
        'DESCRIPTION:${item.description}',
        if (item.start != null)
          'DTSTART:${item.start!.toUtc().toIso8601String()}',
        if (item.end != null) 'DTEND:${item.end!.toUtc().toIso8601String()}',
        'END:VEVENT',
      ];

  List<String> writeNote(Note note) => [
        'BEGIN:VTODO',
        'SUMMARY:${note.name}',
        'END:VTODO',
      ];

  List<String> write() {
    final lines = <String>[];
    lines.add('BEGIN:VCALENDAR');
    lines.add('VERSION:2.0');
    lines.addAll(data?.items.expand(writeEvent) ?? []);
    lines.addAll(data?.notes.expand(writeNote) ?? []);
    lines.add('END:VCALENDAR');
    return lines;
  }
}
