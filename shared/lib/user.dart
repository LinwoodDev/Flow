import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@UseRowClass(User)
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get displayName => text().nullable()();
  TextColumn get bio => text().withDefault(const Constant(''))();
  TextColumn get email => text()();
  TextColumn get password => text()();
  IntColumn get series => integer().nullable()();
  IntColumn get state => integer().map(UserStateConverter())();
}

@immutable
class User {
  final int? id;
  final String name;
  final String displayName;
  final String bio;
  final String email;
  final String password;
  final UserState state;

  User(this.name,
      {String? displayName,
      this.id,
      this.bio = '',
      required this.email,
      this.password = '',
      this.state = UserState.active})
      : displayName = displayName ?? name;

  User copyWith(
          {String? name,
          String? displayName,
          String? bio,
          String? email,
          String? password,
          UserState? state}) =>
      User(name ?? this.name,
          id: id,
          state: state ?? this.state,
          displayName: displayName ?? this.displayName,
          bio: bio ?? this.bio,
          email: email ?? this.email,
          password: password ?? this.password);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? '',
        displayName = json['display-name'],
        bio = json['bio'] ?? '',
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.active;

  Map<String, dynamic> toJson() =>
      {'name': name, 'display-name': displayName, 'email': email, 'bio': bio, 'state': state.index};
}

enum UserState { confirm, active, punished }

class UserStateConverter extends TypeConverter<UserState, int> {
  const UserStateConverter();
  @override
  UserState? mapToDart(int? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return UserState.values[fromDb];
  }

  @override
  int? mapToSql(UserState? value) => value?.index;
}
