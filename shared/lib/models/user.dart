import 'package:meta/meta.dart';
import 'package:shared/models/json_object.dart';

@immutable
class User extends JsonObject {
  final int? id;
  final String name, displayName, bio, email, password, salt;
  final bool admin;
  final UserState state;

  User(this.name,
      {this.displayName = '',
      this.id,
      this.bio = '',
      this.email = '',
      this.password = '',
      this.salt = '',
      this.state = UserState.active,
      this.admin = false});

  @override
  User copyWith(
          {String? name,
          String? displayName,
          String? bio,
          String? email,
          String? password,
          String? salt,
          UserState? state,
          bool? admin,
          int? id}) =>
      User(name ?? this.name,
          id: id ?? this.id,
          state: state ?? this.state,
          displayName: displayName ?? this.displayName,
          bio: bio ?? this.bio,
          email: email ?? this.email,
          password: password ?? this.password,
          salt: salt ?? this.salt,
          admin: admin ?? this.admin);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        displayName = json['display-name'] ?? '',
        bio = json['bio'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.values[json['state'] ?? 0],
        salt = json['salt'] ?? '',
        admin = json['admin'] ?? false;

  @override
  Map<String, dynamic> toJson({bool addSecrets = false, bool addId = false}) =>
      {
        'name': name,
        'display-name': displayName,
        'bio': bio,
        'state': state.index,
        'admin': admin
      }
        ..addAll(addSecrets
            ? {'email': email, 'password': password, 'salt': salt}
            : {})
        ..addAll(addId ? {'id': id} : {});

  bool valid() => name.isNotEmpty && email.isNotEmpty;

  @override
  List<Object?> get props => [id];
}

enum UserState { confirm, active, fake, punished }
