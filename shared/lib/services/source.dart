import 'package:shared/models/event/service.dart';
import 'package:shared/models/user/service.dart';

abstract class SourceService {
  EventService get event;
  EventGroupService get eventGroup;

  UserService get user;
  UserGroupService get userGroup;
}
