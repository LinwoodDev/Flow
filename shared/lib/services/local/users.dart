import 'package:sembast/sembast.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/api_service.dart';

import '../../utils.dart';

class UsersLocalService extends UsersApiService {
  final Database db;

  static const String usersStoreName = 'users';
  final usersStore = intMapStoreFactory.store(usersStoreName);

  UsersLocalService(this.db);

  @override
  Future<User> createUser(User user) async {
    var errors = <InputError>[];
    if (user.name.isEmpty) errors.add(InputError("name.empty"));
    if (user.email.isEmpty) errors.add(InputError("email.empty"));
    if (user.password.isEmpty) errors.add(InputError("password.empty"));
    if (errors.isNotEmpty) throw InputException(errors);
    if (await fetchUserByName(user.name) != null) {
      errors.add(InputError("name.exist"));
    }
    if (await fetchUserByEmail(user.email) != null) {
      errors.add(InputError("email.exist"));
    }
    if (errors.isNotEmpty) throw InputException(errors);
    var salt = generateSalt();
    return usersStore
        .add(
        db,
        user
            .copyWith(
            password: hashPassword(user.password, salt), salt: salt)
            .toJson(addSecrets: true))
        .then((value) => user.copyWith(id: value));
  }

  @override
  Future<List<User>> fetchUsers() => usersStore.find(db).then((value) => value
      .map((e) => User.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<int> fetchUsersCount() => usersStore.count(db);

  @override
  Future<User?> fetchUser(int id) => usersStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
      ? null
      : User.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<User?> fetchUserByEmail(String email) => usersStore
      .findFirst(db, finder: Finder(filter: Filter.equals("email", email)))
      .then((value) => value == null
      ? null
      : User.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<User?> fetchUserByName(String name) => usersStore
      .findFirst(db, finder: Finder(filter: Filter.equals("name", name)))
      .then((value) => value == null
      ? null
      : User.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateUser(User user) async {
    if (user.id == null) throw InputException([InputError("empty")]);

    if (await usersStore.update(db, user.toJson(),
        finder: Finder(filter: Filter.byKey(user.id))) ==
        await usersStore.count(db)) {
      throw InputException([InputError("invalid")]);
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    if (await usersStore.delete(db, finder: Finder(filter: Filter.byKey(id))) ==
        await usersStore.count(db)) {
      throw InputException([InputError("invalid")]);
    }
  }

  @override
  Stream<List<User>> onUsers() =>
      usersStore.query().onSnapshots(db).map((event) => event
          .map((e) => User.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<User?> onUser(int id) => usersStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) =>
  e == null ? null : User.fromJson(Map.from(e.value)..["id"] = e.key));

  @override
  Future<bool> hasUser(User user) => fetchUserByEmail(user.email).then(
          (emailVerify) => fetchUserByName(user.name)
          .then((nameVerify) => (emailVerify != null || nameVerify != null)));
}