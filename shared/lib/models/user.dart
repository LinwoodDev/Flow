import 'package:isar/isar.dart';
import 'package:meta/meta.dart';

import 'group.dart';

@immutable
class User {
  @Id()
  final int id;
  final String name;
  final String displayName;
  final String email;
  final String password;
  final group = IsarLink<UserGroup>();

  User(this.id, {this.name, this.displayName, this.email, this.password});

  User copyWith({String name, String displayName, String email, String password}) => User(id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password);
}
