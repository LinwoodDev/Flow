import 'package:shared/models/cached.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/note/model.dart';

import '../models/event/appointment/model.dart';

class ICalConverter {
  String summary = '';
  CachedData? data;

  void read(List<String> lines) {
    final offset =
        lines.indexWhere((element) => element.trim() == 'BEGIN:VCALENDAR');
    if (offset == -1) {
      return;
    }
    Appointment? currentAppointment;
    Note? currentNote;
    final appointments = List<Appointment>.from(data?.appointments ?? []);
    final events = List<Event>.from(data?.events ?? []);
    final notes = List<Note>.from(data?.notes ?? []);
    for (int i = offset; i < lines.length; i++) {
      final line = lines[i];
      final parts = line.split(':');
      final name = parts[0].trim().split(';');
      final key = name.first;
      final value = parts.sublist(1).join(':').trim();
      if (currentAppointment != null) {
        switch (key) {
          case 'SUMMARY':
            currentAppointment = currentAppointment.copyWith(name: value);
            break;
          case 'DESCRIPTION':
            currentAppointment =
                currentAppointment.copyWith(description: value);
            break;
          case 'DTSTART':
            currentAppointment = currentAppointment.copyWith(
                start:
                    DateTime.parse(value).subtract(const Duration(minutes: 1)));
            break;
          case 'DTEND':
            currentAppointment =
                currentAppointment.copyWith(end: DateTime.parse(value));
            break;
          case 'END':
            if (value != 'VEVENT') break;
            appointments.add(currentAppointment);
            currentAppointment = null;
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
            summary = value;
            break;
          case 'BEGIN':
            if (value == 'VEVENT') {
              final event = Event(id: events.length + 1);
              events.add(event);
              currentAppointment = Appointment.fixed(
                id: appointments.length + 1,
                eventId: event.id,
              );
            } else if (value == 'VTODO') {
              currentNote = Note();
            }
            continue;
          case 'END':
            if (value == 'VCALENDAR') {
              data = CachedData(
                events: events,
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
    for (final event in data?.appointments ?? <Appointment>[]) {
      lines.add('BEGIN:VEVENT');
      lines.add('SUMMARY:${event.name}');
      lines.add('DESCRIPTION:${event.description}');
      if (event.start != null) {
        lines.add('DTSTART:${event.start!.toUtc().toIso8601String()}');
      }
      if (event.end != null) {
        lines.add('DTEND:${event.end!.toUtc().toIso8601String()}');
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
