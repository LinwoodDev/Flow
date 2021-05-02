import 'package:isar/isar.dart';
import 'user.dart';

@Collection()
class UserGroup {
  @Id()
  late int id = 0;
  late String name;
  late String description = '';
  late int? color;
  final users = IsarLinks<User>();

  UserGroup();
  UserGroup.fromValue(this.id, {required this.name, this.description = '', this.color});
  UserGroup.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        description = json['description'] ?? '',
        color = json['color'];
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'description': description, 'color': color};
}
