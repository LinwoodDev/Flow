import 'package:meta/meta.dart';
import 'package:shared/models/jsonobject.dart';

@immutable
class Badge extends JsonObject {
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

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'color': color};

  @override
  Badge copyWith(
          {String? name,
          String? description,
          int? color,
          bool removeColor = false,
          int? id}) =>
      Badge(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : (color ?? this.color));

  @override
  List<Object?> get props => [id];
}
