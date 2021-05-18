import 'series.dart';

import 'package:meta/meta.dart';

@immutable
class Event {
  final int? id;
  final String name;
  final String description;
  final Series? series;
  final EventState state;
  Event(this.name, {this.description = '', this.id, this.series, this.state = EventState.planned});

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        description = json['description'] ?? '',
        state = EventState.values[json['state'] ?? 0],
        series = Series.fromJson(json['series']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'description': description, 'state': state.index, 'series': series?.toJson()};
}

enum EventState { draft, planned, canceled }
