import 'package:shared/models/event/model.dart';
import 'package:shared/models/todo/model.dart';

class ICalConverter {
  String summary = '';
  final List<Event> events = [];
  final List<Todo> todos = [];

  void read(List<String> lines) {
    final offset =
        lines.indexWhere((element) => element.trim() == 'BEGIN:VCALENDAR');
    if (offset == -1) {
      return;
    }
    Event? currentEvent;
    Todo? currentTodo;
    for (int i = offset; i < lines.length; i++) {
      final line = lines[i];
      final parts = line.split(':');
      final key = parts[0].trim();
      final value = parts.sublist(1).join(':').trim();
      if (currentEvent != null) {
        switch (key) {
          case 'SUMMARY':
            currentEvent = currentEvent.copyWith(name: value);
            break;
          case 'DESCRIPTION':
            currentEvent = currentEvent.copyWith(description: value);
            break;
          case 'DTSTART':
          case 'DTEND;VALUE=DATE':
            currentEvent = currentEvent.copyWith(
                start:
                    DateTime.parse(value).subtract(const Duration(minutes: 1)));
            break;
          case 'DTEND':
          case 'DTSTART;VALUE=DATE':
            currentEvent = currentEvent.copyWith(end: DateTime.parse(value));
            break;
          case 'END':
            if (value != 'VEVENT') break;
            events.add(currentEvent);
            currentEvent = null;
            break;
        }
      } else if (currentTodo != null) {
        switch (key) {
          case 'END':
            if (value != 'VTODO') break;
            todos.add(currentTodo);
            currentTodo = null;
            break;
        }
      } else {
        switch (key) {
          case 'SUMMARY':
            summary = value;
            break;
          case 'BEGIN':
            if (value == 'VEVENT') {
              currentEvent = Event();
            } else if (value == 'VTODO') {
              currentTodo = Todo();
            }
            continue;
          case 'END':
            if (value == 'VCALENDAR') {
              return;
            }
            continue;
        }
      }
    }
  }
}
