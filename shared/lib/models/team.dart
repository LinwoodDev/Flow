import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Team extends Equatable {
  final int? id;
  final int? parent;
  final String name;
  final String description;
  final int? color;

  Team(this.name, {this.id, this.parent, this.description = '', this.color});

  Team.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parent = json['parent'],
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'];

  Map<String, dynamic> toJson() => {'name': name, 'description': description, 'color': color, 'parent': parent};

  Team copyWith(
          {String? name,
          String? description,
          int? color,
          int? id,
          int? parent,
          bool removeColor = false,
          bool removeParent = false}) =>
      Team(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : (color ?? this.color),
          parent: removeParent ? null : (parent ?? (this.parent)));

  @override
  List<Object?> get props => [id];
}
