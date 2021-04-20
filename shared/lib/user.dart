import 'package:meta/meta.dart';
import 'package:shared/group.dart';

@immutable
class User {
  final String name;
  final String displayName;
  final String email;
  final String password;
  final teachers = IsarLink<UserGroup>();
}
