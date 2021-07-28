import 'package:meta/meta.dart';
import 'package:shared/models/jsonobject.dart';

import 'assign.dart';

@immutable
class Season extends JsonObject {
  final int? id;
  final String name;
  final int? color;
  final String description;
  final Assigned assigned;

  Season(this.name,
      {this.description = '',
      this.color,
      this.id,
      this.assigned = const Assigned()});

  Season.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        description = json['description'] ?? '',
        assigned = Assigned.fromJson(json['assigned'] ?? {});

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'description': description,
        'assigned': assigned.toJson()
      };

  @override
  Season copyWith(
          {String? name,
          String? description,
          int? color,
          int? id,
          bool removeColor = false,
          Assigned? assigned}) =>
      Season(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          color: removeColor ? null : (color ?? this.color),
          assigned: assigned ?? this.assigned);

  @override
  List<Object?> get props => [id];
}
