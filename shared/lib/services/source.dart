import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/place/service.dart';
import 'package:shared/models/user/service.dart';

import '../models/cached.dart';
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

  Future<void> import(CachedData data) async {
    for (final current in data.events) {
      await event?.createEvent(current);
    }
    for (final current in data.todos) {
      await todo?.createTodo(current);
    }
  }
}

abstract class ModelService {}
