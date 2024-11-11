import 'dart:async';

import 'dart:typed_data';
import 'package:flow_api/services/source.dart';

import 'model.dart';

abstract class GroupService extends ModelService {
  FutureOr<List<Group>> getGroups({
    int offset = 0,
    int limit = 50,
    String search = '',
  });

  FutureOr<Group?> getGroup(Uint8List id);

  FutureOr<Group?> createGroup(Group group);

  FutureOr<bool> updateGroup(Group group);

  FutureOr<bool> deleteGroup(Uint8List id);
}
