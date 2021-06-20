import 'package:meta/meta.dart';

@immutable
class User {
  final int? id;
  final String name;
  final String displayName;
  final String bio;
  final String? email;
  final String password;
  final UserState state;

  User(this.name,
      {this.displayName = '',
      this.id,
      this.bio = '',
      this.email,
      this.password = '',
      this.state = UserState.active});

  User copyWith(
          {String? name,
          String? displayName,
          String? bio,
          String? email,
          String? password,
          UserState? state,
          int? id}) =>
      User(name ?? this.name,
          id: id ?? this.id,
          state: state ?? this.state,
          displayName: displayName ?? this.displayName,
          bio: bio ?? this.bio,
          email: email ?? this.email,
          password: password ?? this.password);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        displayName = json['display-name'] ?? '',
        bio = json['bio'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.values[json['state']];

  Map<String, dynamic> toJson() =>
      {'name': name, 'display-name': displayName, 'email': email, 'bio': bio, 'state': state.index};
}

enum UserState { confirm, active, fake, punished }
