import 'package:meta/meta.dart';

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
