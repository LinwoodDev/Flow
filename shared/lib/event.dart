import 'package:meta/meta.dart';
import 'package:shared/assign.dart';
import 'package:shared/calendar_entry.dart';

@immutable
class Event extends CalendarEntry {
  final int? id;
  final String name;
  final String description;
  final int? season;
  final bool isCanceled;
  @override
  final DateTime? startDateTime;
  @override
  final DateTime? endDateTime;
  final Assigned assigned;
  Event(this.name,
      {this.description = '',
      this.id,
      this.season,
      this.startDateTime,
      this.endDateTime,
      this.assigned = const Assigned(),
      this.isCanceled = false});

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'],
        description = json['description'] ?? '',
        startDateTime = DateTime.tryParse(json['start-date-time'] ?? ''),
        endDateTime = DateTime.tryParse(json['end-date-time'] ?? ''),
        season = json['season'],
        isCanceled = json['canceled'],
        assigned = Assigned.fromJson(json['assigned'] ?? {});

  Map<String, dynamic> toJson() => {
        'description': description,
        'canceled': isCanceled,
        'start-date-time': startDateTime.toString(),
        'end-date-time': endDateTime.toString(),
        'season': season,
        'name': name,
        'assigned': assigned.toJson()
      };

  Event copyWith(
          {String? name,
          String? description,
          int? season,
          bool? isCanceled,
          DateTime? startDateTime,
          DateTime? endDateTime,
          bool removeSeason = false,
          bool removeStartDateTime = false,
          bool removeEndDateTime = false,
          int? id,
          Assigned? assigned}) =>
      Event(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          season: removeSeason ? null : season ?? this.season,
          startDateTime: removeStartDateTime ? null : (startDateTime ?? this.startDateTime),
          endDateTime: removeEndDateTime ? null : (endDateTime ?? this.endDateTime),
          isCanceled: isCanceled ?? this.isCanceled,
          assigned: assigned ?? this.assigned);
}
