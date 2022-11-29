import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/todo/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService get event;
  TodoService get todo;
  PlaceService get place;
  GroupService get group;

  UserService get user;

  List<ModelService> get models => [event, todo, group, user, place];
}

abstract class ModelService {}
