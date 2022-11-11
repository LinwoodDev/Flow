import 'dart:async';

import 'package:shared/services/source.dart';

import 'model.dart';

abstract class EventService extends ModelService {
  FutureOr<Event?> getEvent(int id);
  FutureOr<List<Event>> getEvents({
    List<EventStatus> status,
  });

  FutureOr<Event?> createEvent(Event event);

  FutureOr<bool> updateEvent(Event event);

  FutureOr<bool> deleteEvent(int id);
}

abstract class EventGroupService extends ModelService {
  FutureOr<List<EventGroup>> getGroups();
}

abstract class EventTodoService extends ModelService {
  FutureOr<List<EventTodo>> getTodos({
    int? eventId,
    int offset = 0,
    int limit = 50,
    bool incomplete = true,
    bool completed = true,
  });

  FutureOr<bool?> todosDone(int eventId);

  FutureOr<EventTodo?> createTodo(EventTodo todo);

  FutureOr<bool> updateTodo(EventTodo todo);

  FutureOr<bool> deleteTodo(int id);
}
