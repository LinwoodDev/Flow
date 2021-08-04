import 'package:meta/meta.dart';
import 'package:shared/models/json_object.dart';

import 'assign.dart';

@immutable
class Task extends JsonObject {
  final int? id;
  final String name;
  final String description;
  final Assigned assigned;
  final int? event;
  final int? parent;

  Task(this.name,
      {this.id,
      this.description = '',
      this.assigned = const Assigned(),
      this.parent,
      this.event});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        assigned = Assigned.fromJson(json['assigned'] ?? {}),
        parent = json['parent'],
        event = json['event'];

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'assigned': assigned.toJson(),
        'event': event
      };

  @override
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

  @override
  List<Object?> get props => [id];
}

@immutable
class Submission extends JsonObject {
  final int? id;
  final int? task;
  final int? user;
  final SubmissionState state;

  Submission(
      {this.id, this.task, this.user, this.state = SubmissionState.open});

  Submission.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        task = json['task'],
        user = json['user'],
        state = SubmissionState.values[json['state']];

  @override
  Map<String, dynamic> toJson() =>
      {'task': task, 'user': user, 'state': state.index};

  @override
  List<Object?> get props => [id];

  @override
  Submission copyWith({int? id, SubmissionState? state}) =>
      Submission(id: id ?? this.id, state: state ?? this.state);
}

enum SubmissionState { open, progress, done, closed }

enum SubmissionType { file }

extension SubmissionTypeExtension on SubmissionType {}

class FileSubmissionType {}
