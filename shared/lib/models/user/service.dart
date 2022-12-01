import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class UserService extends ModelService {
  FutureOr<List<User>> getUsers({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<User?> createUser(User user);

  FutureOr<bool> updateUser(User user);

  FutureOr<bool> deleteUser(int id);
}
