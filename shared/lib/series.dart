import 'package:meta/meta.dart';

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
}
