import 'package:shared/models/event/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/team/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/todo/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService get event;
  EventGroupService get eventGroup;
  TodoService get todo;
  PlaceService get place;
  TeamService get team;

  UserService get user;
  UserGroupService get userGroup;

  List<ModelService> get models =>
      [event, eventGroup, todo, user, userGroup, place];
}

abstract class ModelService {}
