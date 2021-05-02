import 'package:isar/isar.dart';
import 'series.dart';

@Collection()
class Event {
  @Id()
  int? id = 0;
  late String description = '';
  final series = IsarLink<Series>();
  @EventStateConverter()
  late EventState state;

  Event();
  Event.fromValue({this.description = '', this.state = EventState.draft});
  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        description = json['description'] ?? '',
        state = EventState.values[json['state'] ?? 0];

  Map<String, dynamic> toJson() => {'id': id, 'description': description, 'state': state.index};
}

enum EventState { draft, planned, canceled }

class EventStateConverter extends TypeConverter<EventState, int> {
  const EventStateConverter(); // Converters need to have an empty const constructor

  @override
  EventState fromIsar(int index) {
    return EventState.values[index];
  }

  @override
  int toIsar(EventState state) {
    return state.index;
  }
}
