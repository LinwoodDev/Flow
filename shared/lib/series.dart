import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@UseRowClass(Series)
class SeriesCollection extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get color => integer().nullable()();
}

@immutable
class Series {
  final int? id;
  final String name;
  final int? color;
  final String description;

  Series(this.name, {this.description = '', this.color, this.id});

  Series.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        description = json['description'] ?? '';
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'color': color, 'description': description};

  Series copyWith({String? name, String? description, int? color, bool removeColor = false}) =>
      Series(name ?? this.name,
          description: description ?? this.description,
          id: id,
          color: removeColor ? null : color ?? this.color);
}
