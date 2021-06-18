import 'package:meta/meta.dart';

@immutable
class Season {
  final int? id;
  final String name;
  final int? color;
  final String description;

  Season(this.name, {this.description = '', this.color, this.id});

  Season.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        description = json['description'] ?? '';
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'color': color, 'description': description};

  Season copyWith(
          {String? name, String? description, int? color, int? id, bool removeColor = false}) =>
      Season(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : color ?? this.color);
}
