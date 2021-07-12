import 'package:meta/meta.dart';
import 'package:shared/models/assign.dart';

import 'jsonobject.dart';

@immutable
class Place extends JsonObject {
  final int? id;
  final String name;
  final String description;
  final Assigned assigned;

  Place(this.name, {this.id, this.description = '', this.assigned = const Assigned()});

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '',
        assigned = Assigned.fromJson(json['assigned'] ?? {});

  @override
  Map<String, dynamic> toJson() => {'name': name, 'description': description, 'assigned': assigned.toJson()};

  @override
  Place copyWith({String? name, String? description, int? id, Assigned? assigned}) => Place(name ?? this.name,
      description: description ?? this.description, id: id ?? this.id, assigned: assigned ?? this.assigned);

  @override
  List<Object?> get props => [id];
}
