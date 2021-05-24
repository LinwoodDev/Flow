import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@UseRowClass(Place)
class Places extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
}

@immutable
class Place {
  final int? id;
  final String name;
  final String description;

  Place(this.name, {this.id, this.description = ''});
  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description};

  Place copyWith({String? name, String? description}) =>
      Place(name ?? this.name, description: description ?? this.description, id: id);
}
