import 'package:meta/meta.dart';

@immutable
class User {
  final int? id;
  final String name;
  final String displayName;
  final String email;
  final String password;
  final UserState state;

  User(this.name,
      {String? displayName,
      this.id,
      required this.email,
      this.password = '',
      this.state = UserState.active})
      : displayName = displayName ?? name;

  User copyWith({String? name, String? displayName, String? email, String? password}) =>
      User(name ?? this.name,
          displayName: displayName ?? this.displayName,
          email: email ?? this.email,
          password: password ?? this.password);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        displayName = json['display-name'],
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.active;

  Map<String, dynamic> toJson() => {'name': name, 'display-name': displayName, 'email': email};
}

enum UserState { confirm, active, punished }
