import 'package:meta/meta.dart';

enum AssignFlag { allow, neutral, disallow }

@immutable
class Assigned {
  final AssignFlag everyone;
  final List<AssignedObject> teams;
  final List<AssignedObject> users;
  final List<AssignedObject> events;

  const Assigned(
      {this.teams = const [],
      this.users = const [],
      this.events = const [],
      this.everyone = AssignFlag.allow});
  Assigned.fromJson(Map<String, dynamic> json)
      : teams = List.from(json['teams'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        users = List.from(json['users'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        events = List.from(json['events'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        everyone = AssignFlag.values[json['everyone'] ?? 0];

  Map<String, dynamic> toJson() => {
        'teams': teams.map((e) => e.toJson()).toList(),
        'users': users.map((e) => e.toJson()).toList(),
        'events': events.map((e) => e.toJson()).toList(),
        'everyone': everyone.index
      };
  Assigned copyWith(
          {AssignFlag? everyone,
          List<AssignedObject>? teams,
          List<AssignedObject>? users,
          List<AssignedObject>? events}) =>
      Assigned(
          teams: teams ?? this.teams,
          events: events ?? this.events,
          everyone: everyone ?? this.everyone,
          users: users ?? this.users);
}

@immutable
class AssignedObject {
  final int? id;
  final AssignFlag flag;
  const AssignedObject({this.id, required this.flag});
  AssignedObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        flag = AssignFlag.values[json['flag'] ?? 0];

  AssignedObject copyWith({int? id, AssignFlag? flag}) =>
      AssignedObject(flag: flag ?? this.flag, id: id ?? this.id);

  Map<String, dynamic> toJson() => {'id': id, 'flag': flag.index};
}
