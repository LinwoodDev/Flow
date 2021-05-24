import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@UseRowClass(Event)
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get series => integer().nullable()();
  IntColumn get state => integer().map(EventStateConverter())();
}

@immutable
class Event {
  final int? id;
  final String name;
  final String description;
  final int? series;
  final EventState state;
  Event(this.name, {this.description = '', this.id, this.series, this.state = EventState.planned});

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        description = json['description'] ?? '',
        state = EventState.values[json['state'] ?? 0],
        series = json['series'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'description': description, 'state': state.index, 'series': series};

  Event copyWith(
          {String? name,
          String? description,
          int? series,
          EventState? state,
          bool removeSeries = false}) =>
      Event(name ?? this.name,
          description: description ?? this.description,
          id: id,
          series: removeSeries ? null : series ?? this.series,
          state: state ?? this.state);
}

enum EventState { draft, planned, canceled }

class EventStateConverter extends TypeConverter<EventState, int> {
  const EventStateConverter();
  @override
  EventState? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return EventState.values[fromDb];
  }

  @override
  int? mapToSql(EventState? value) => value?.index;
}
