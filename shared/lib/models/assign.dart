import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Assigned {
  final bool? everyone;
  final List<AssignedObject> teams;
  final List<AssignedObject> users;
  final List<AssignedObject> events;

  const Assigned({this.teams = const [], this.users = const [], this.events = const [], this.everyone});

  Assigned.fromJson(Map<String, dynamic> json)
      : teams = List.from(json['teams'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        users = List.from(json['users'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        events = List.from(json['events'] ?? []).map((e) => AssignedObject.fromJson(e)).toList(),
        everyone = json['everyone'];

  Map<String, dynamic> toJson() => {
        'teams': teams.map((e) => e.toJson()).toList(),
        'users': users.map((e) => e.toJson()).toList(),
        'events': events.map((e) => e.toJson()).toList(),
        'everyone': everyone
      };

  Assigned copyWith(
          {bool? everyone,
          bool removeEveryone = false,
          List<AssignedObject>? teams,
          List<AssignedObject>? users,
          List<AssignedObject>? events}) =>
      Assigned(
          teams: teams ?? this.teams,
          events: events ?? this.events,
          everyone: removeEveryone ? true : (everyone ?? this.everyone),
          users: users ?? this.users);
}

@immutable
class AssignedObject extends Equatable {
  final int? id;
  final bool? flag;

  const AssignedObject({this.id, required this.flag});

  AssignedObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        flag = json['flag'];

  AssignedObject copyWith({int? id, bool? flag, bool removeFlag = false}) =>
      AssignedObject(flag: removeFlag ? null : (flag ?? this.flag), id: id ?? this.id);

  Map<String, dynamic> toJson() => {'id': id, 'flag': flag};

  @override
  List<Object?> get props => [id];
}
