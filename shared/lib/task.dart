import 'package:meta/meta.dart';

import 'assign.dart';
import 'calendar_entry.dart';

@immutable
class Task extends CalendarEntry {
  final int? id;
  final String name;
  final String description;
  final Assigned assigned;
  @override
  final DateTime? startDateTime;
  @override
  final DateTime? endDateTime;
  final int? parent;

  Task(this.name,
      {this.id,
      this.description = '',
      this.assigned = const Assigned(),
      this.parent,
      this.startDateTime,
      this.endDateTime});
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        assigned = Assigned.fromJson(json['assigned'] ?? {}),
        parent = json['parent'],
        startDateTime = DateTime.tryParse(json['start-date-time'] ?? ''),
        endDateTime = DateTime.tryParse(json['end-date-time'] ?? '');
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'assigned': assigned.toJson(),
        'start-date-time': startDateTime.toString(),
        'end-date-time': endDateTime.toString()
      };
  Task copyWith(
          {String? name,
          String? description,
          int? id,
          int? parent,
          Assigned? assigned,
          DateTime? startDateTime,
          DateTime? endDateTime,
          bool removeStartDateTime = false,
          bool removeEndDateTime = false,
          bool removeParent = false}) =>
      Task(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          assigned: assigned ?? this.assigned,
          parent: removeParent ? null : (parent ?? this.parent),
          startDateTime: removeStartDateTime ? null : (startDateTime ?? this.startDateTime),
          endDateTime: removeEndDateTime ? null : (endDateTime ?? this.endDateTime));
}
