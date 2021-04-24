import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:shared/models/user.dart';

@immutable
@Collection()
class UserGroup {
  @Id()
  final int id;
  final String? name;
  final String? description;
  final int? color;
  final users = IsarLinks<User>();

  UserGroup(this.id, {this.name, this.description, this.color});
}
