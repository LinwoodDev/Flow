import 'package:meta/meta.dart';
import 'package:shared/models/assign.dart';
import 'package:shared/models/json_object.dart';

@immutable
class Team extends JsonObject {
  final int? id;
  final int? parent;
  final String name;
  final String description;
  final int? color;
  final Assigned teamAdmin, subAdmin;
  final Assigned admin, teamsAdmin, usersAdmin, eventsAdmin;

  Team(
    this.name, {
    this.id,
    this.parent,
    this.description = '',
    this.color,
    this.teamAdmin = const Assigned(),
    this.subAdmin = const Assigned(),
    this.admin = const Assigned(),
    this.teamsAdmin = const Assigned(),
    this.usersAdmin = const Assigned(),
    this.eventsAdmin = const Assigned(),
  });

  Team.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parent = json['parent'],
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'],
        teamAdmin = json['team-admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['team-admin']),
        subAdmin = json['sub-admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['sub-admin']),
        admin = json['admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['admin']),
        teamsAdmin = json['teams-admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['teams-admin']),
        usersAdmin = json['users-admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['users-admin']),
        eventsAdmin = json['events-admin'] == null
            ? Assigned()
            : Assigned.fromJson(json['events-admin']);

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'color': color,
        'parent': parent,
        'team-admin': teamAdmin.toJson(),
        'sub-admin': subAdmin.toJson(),
        'admin': admin.toJson(),
        'teams-admin': teamsAdmin.toJson(),
        'users-admin': usersAdmin.toJson(),
        'events-admin': eventsAdmin.toJson()
      };

  @override
  Team copyWith(
          {String? name,
          String? description,
          int? color,
          int? id,
          int? parent,
          bool removeColor = false,
          bool removeParent = false,
          Assigned? teamAdmin,
          Assigned? subAdmin,
          Assigned? admin,
          Assigned? teamsAdmin,
          Assigned? usersAdmin,
          Assigned? eventsAdmin}) =>
      Team(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : (color ?? this.color),
          parent: removeParent ? null : (parent ?? (this.parent)),
          teamAdmin: teamAdmin ?? this.teamAdmin,
          subAdmin: subAdmin ?? this.subAdmin,
          admin: admin ?? this.admin,
          teamsAdmin: teamsAdmin ?? this.teamsAdmin,
          usersAdmin: usersAdmin ?? this.usersAdmin,
          eventsAdmin: eventsAdmin ?? this.eventsAdmin);

  @override
  List<Object?> get props => [id];
}
