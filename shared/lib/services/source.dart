import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/todo/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService? get event => null;
  TodoService? get todo => null;
  PlaceService? get place => null;
  GroupService? get group => null;
  UserService? get user => null;

  List<ModelService> get models =>
      [event, todo, group, user, place].whereType<ModelService>().toList();
}

abstract class ModelService {}
