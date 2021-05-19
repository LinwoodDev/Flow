import 'package:meta/meta.dart';

@immutable
class UserGroup {
  final int? id;
  final String name;
  final String description;
  final int? color;

  UserGroup(this.name, {this.id, this.description = '', this.color});
  UserGroup.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'];
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'color': color};
  UserGroup copyWith({String? name, String? description, int? color, bool removeColor = false}) =>
      UserGroup(name ?? this.name,
          description: description ?? this.description,
          id: id,
          color: removeColor ? null : color ?? this.color);
}
