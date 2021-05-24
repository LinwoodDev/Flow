import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@UseRowClass(Team)
class Teams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get color => integer().nullable()();
}

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
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'color': color};
  Team copyWith({String? name, String? description, int? color, bool removeColor = false}) =>
      Team(name ?? this.name,
          description: description ?? this.description,
          id: id,
          color: removeColor ? null : color ?? this.color);
}
