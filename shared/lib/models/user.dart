import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  final int? id;
  final String name;
  final String displayName;
  final String bio;
  final String email;
  final String password;
  final String salt;
  final UserState state;

  User(this.name,
      {this.displayName = '',
      this.id,
      this.bio = '',
      this.email = '',
      this.password = '',
      this.salt = '',
      this.state = UserState.active});

  User copyWith(
          {String? name,
          String? displayName,
          String? bio,
          String? email,
          String? password,
          String? salt,
          UserState? state,
          int? id}) =>
      User(name ?? this.name,
          id: id ?? this.id,
          state: state ?? this.state,
          displayName: displayName ?? this.displayName,
          bio: bio ?? this.bio,
          email: email ?? this.email,
          password: password ?? this.password,
          salt: salt ?? this.salt);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        displayName = json['display-name'] ?? '',
        bio = json['bio'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.values[json['state'] ?? 0],
        salt = json['salt'] ?? '';

  Map<String, dynamic> toJson({bool addSecrets = false, bool addId = false}) =>
      {'name': name, 'display-name': displayName, 'email': email, 'bio': bio, 'state': state.index}
        ..addAll(addSecrets ? {'password': password, 'salt': salt} : {})
        ..addAll(addId ? {'id': id} : {});

  bool valid() => name.isNotEmpty && email.isNotEmpty;

  @override
  List<Object?> get props => [id];
}

enum UserState { confirm, active, fake, punished }
