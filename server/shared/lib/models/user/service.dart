import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/services/source.dart';

import 'model.dart';

abstract class UserService extends ModelService {
  FutureOr<List<User>> getUsers({
    int offset = 0,
    int limit = 50,
    String search = '',
    Multihash? groupId,
  });

  FutureOr<User?> createUser(User user);

  FutureOr<bool> updateUser(User user);

  FutureOr<bool> deleteUser(Multihash id);
}
