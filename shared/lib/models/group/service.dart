import 'dart:async';

import 'package:lib5/lib5.dart';
import 'package:shared/services/source.dart';

import 'model.dart';

abstract class GroupService extends ModelService {
  FutureOr<List<Group>> getGroups({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Group?> getGroup(Multihash id);

  FutureOr<Group?> createGroup(Group group);

  FutureOr<bool> updateGroup(Group group);

  FutureOr<bool> deleteGroup(Multihash id);
}
