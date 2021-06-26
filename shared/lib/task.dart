import 'package:meta/meta.dart';

import 'assign.dart';

@immutable
class Task {
  final int? id;
  final String name;
  final String description;
  final Assigned assigned;
  final int? event;
  final int? parent;

  Task(this.name,
      {this.id, this.description = '', this.assigned = const Assigned(), this.parent, this.event});
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        assigned = Assigned.fromJson(json['assigned'] ?? {}),
        parent = json['parent'],
        event = json['event'];
  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'assigned': assigned.toJson(), 'event': event};
  Task copyWith(
          {String? name,
          String? description,
          int? id,
          int? parent,
          int? event,
          Assigned? assigned,
          bool removeEvent = false,
          bool removeParent = false}) =>
      Task(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          assigned: assigned ?? this.assigned,
          parent: removeParent ? null : (parent ?? this.parent),
          event: removeEvent ? null : (event ?? this.event));
}
