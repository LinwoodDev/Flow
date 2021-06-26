import 'package:meta/meta.dart';

@immutable
class Badge {
  final int? id;
  final String name;
  final String description;
  final int? color;

  Badge(this.name, {this.id, this.description = '', this.color});
  Badge.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'];
  Map<String, dynamic> toJson() => {'name': name, 'description': description, 'color': color};
  Badge copyWith(
          {String? name, String? description, int? color, bool removeColor = false, int? id}) =>
      Badge(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : (color ?? this.color));
}
