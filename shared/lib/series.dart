import 'package:isar/isar.dart';

@Collection()
class Series {
  @Id()
  late int id = 0;
  late String name;
  late int? color;
  late String description = '';

  Series();

  Series.fromValue({this.description = '', this.color, required this.name});

  Series.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        color = json['color'],
        description = json['description'] ?? '';
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'color': color, 'description': description};
}
