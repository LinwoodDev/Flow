import 'package:isar/isar.dart';

class Place {
  @Id()
  late int id = 0;
  late String name;

  Place();
  Place.fromValue({required this.name});
  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
