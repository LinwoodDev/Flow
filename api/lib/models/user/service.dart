import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class UserService extends ModelService {
  FutureOr<List<User>> getUsers({
    int offset = 0,
    int limit = 50,
    String search = '',
    Uint8List? groupId,
  });

  FutureOr<User?> createUser(User user);

  FutureOr<bool> updateUser(User user);

  FutureOr<bool> deleteUser(Uint8List id);

  FutureOr<User?> getUser(Uint8List id);
}
