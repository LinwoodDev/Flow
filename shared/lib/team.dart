import 'package:meta/meta.dart';

@immutable
class Team {
  final int? id;
  final String name;
  final String description;
  final int? color;

  Team(this.name, {this.id, this.description = '', this.color});
  Team.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'];
  Map<String, dynamic> toJson() => {'name': name, 'description': description, 'color': color};
  Team copyWith(
          {String? name, String? description, int? color, int? id, bool removeColor = false}) =>
      Team(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : color ?? this.color);
}
