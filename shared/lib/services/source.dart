import 'package:shared/models/event/service.dart';
import 'package:shared/models/user/service.dart';

const apiVersion = 0;

abstract class SourceService {
  EventService get event;
  EventGroupService get eventGroup;
  EventTodoService get eventTodo;

  UserService get user;
  UserGroupService get userGroup;

  List<ModelService> get models => [
        event,
        eventGroup,
        eventTodo,
        user,
        userGroup,
      ];
}

abstract class ModelService {}
