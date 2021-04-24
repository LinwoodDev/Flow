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

  User(this.id,
      {required this.name, required this.displayName, required this.email, required this.password});

  User copyWith({String? name, String? displayName, String? email, String? password}) => User(id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        displayName = json['display-name'] ?? json['name'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '';

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'display-name': displayName, 'email': email};
}
