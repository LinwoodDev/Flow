enum AssignFlag { allow, neutral, disallow }

class Assigned {
  final AssignedObject everyone;
  final List<AssignedObject> groups;
  final List<AssignedObject> users;
  final List<AssignedObject> events;

  const Assigned(
      {this.groups = const [],
      this.users = const [],
      this.events = const [],
      this.everyone = const AssignedObject(flag: AssignFlag.allow)});
  Assigned.fromJson(Map<String, dynamic> json)
      : groups = (json['groups'] as List<Map<String, dynamic>>)
            .map((e) => AssignedObject.fromJson(e))
            .toList(),
        users = (json['users'] as List<Map<String, dynamic>>)
            .map((e) => AssignedObject.fromJson(e))
            .toList(),
        events = (json['events'] as List<Map<String, dynamic>>)
            .map((e) => AssignedObject.fromJson(e))
            .toList(),
        everyone = AssignedObject.fromJson(json['everyone']);

  Map<String, dynamic> toJson() => {
        'groups': groups.map((e) => e.toJson()).toList(),
        'users': users.map((e) => e.toJson()).toList(),
        'events': events.map((e) => e.toJson()).toList(),
        'everyone': everyone.toJson()
      };
}

class AssignedObject {
  final int? id;
  final AssignFlag flag;
  const AssignedObject({this.id, required this.flag});
  AssignedObject.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        flag = AssignFlag.values[json['flag']];

  AssignedObject copyWith({int? id, AssignFlag? flag}) =>
      AssignedObject(flag: flag ?? this.flag, id: id ?? this.id);

  Map<String, dynamic> toJson() => {'id': id, 'flag': flag.index};
}
