import 'package:meta/meta.dart';
import 'package:shared/assign.dart';

@immutable
class Event {
  final int? id;
  final String name;
  final String description;
  final int? season;
  final EventState state;
  final Assigned assigned;
  Event(this.name,
      {this.description = '',
      this.id,
      this.season,
      this.state = EventState.planned,
      this.assigned = const Assigned()});

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'],
        description = json['description'] ?? '',
        state = EventState.values[json['state'] ?? 0],
        season = json['season'],
        assigned = Assigned.fromJson(json['assigned'] ?? {});

  Map<String, dynamic> toJson() => {
        'description': description,
        'state': state.index,
        'season': season,
        'name': name,
        'assigned': assigned.toJson()
      };

  Event copyWith(
          {String? name,
          String? description,
          int? season,
          EventState? state,
          bool removeSeason = false,
          int? id,
          Assigned? assigned}) =>
      Event(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          season: removeSeason ? null : season ?? this.season,
          state: state ?? this.state,
          assigned: assigned ?? this.assigned);
}

enum EventState { draft, planned, canceled }
