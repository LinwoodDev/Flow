import 'package:isar/isar.dart';

import 'group.dart';

@Collection()
class User {
  int? id;
  late String name;
  late String? displayName;
  late String email = '';
  late String password = '';
  @UserStateConverter()
  late UserState state;
  final group = IsarLink<UserGroup>();

  User();
  User.fromValue(
      {this.name = '',
      this.displayName,
      required this.email,
      this.password = '',
      this.state = UserState.active});

  User copyWith({String? name, String? displayName, String? email, String? password}) => User()
    ..name = name ?? this.name
    ..displayName = displayName ?? this.displayName
    ..email = email ?? this.email
    ..password = password ?? this.password;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        displayName = json['display-name'],
        email = json['email'] ?? '',
        password = json['password'] ?? '',
        state = UserState.active;

  Map<String, dynamic> toJson() =>
      {'name': name, 'display-name': displayName ?? name, 'email': email};
}

enum UserState { confirm, active, punished }

class UserStateConverter extends TypeConverter<UserState, int> {
  const UserStateConverter(); // Converters need to have an empty const constructor

  @override
  UserState fromIsar(int relationshipIndex) {
    return UserState.values[relationshipIndex];
  }

  @override
  int toIsar(UserState relationship) {
    return relationship.index;
  }
}
