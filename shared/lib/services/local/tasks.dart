import 'package:sembast/sembast.dart';
import 'package:shared/models/task.dart';
import 'package:shared/services/api_service.dart';

class TasksLocalService extends TasksApiService {
  final Database db;
  static const String tasksStoreName = 'tasks';
  final tasksStore = intMapStoreFactory.store(tasksStoreName);

  TasksLocalService(this.db);

  @override
  Future<Task> createTask(Task task) => tasksStore
      .add(db, task.toJson())
      .then((value) => task.copyWith(id: value));

  @override
  Future<List<Task>> fetchTasks() => tasksStore.find(db).then((value) => value
      .map((e) => Task.fromJson(Map.from(e.value)..["id"] = e.key))
      .toList());

  @override
  Future<int> fetchTasksCount() => tasksStore.count(db);

  @override
  Future<Task?> fetchTask(int id) => tasksStore
      .findFirst(db, finder: Finder(filter: Filter.byKey(id)))
      .then((value) => value == null
          ? null
          : Task.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Future<void> updateTask(Task task) => tasksStore.update(db, task.toJson(),
      finder: Finder(filter: Filter.byKey(task.id)));

  @override
  Future<void> deleteTask(int id) =>
      tasksStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Stream<List<Task>> onTasks() =>
      tasksStore.query().onSnapshots(db).map((task) => task
          .map((e) => Task.fromJson(Map.from(e.value)..["id"] = e.key))
          .toList());

  @override
  Stream<Task?> onTask(int id) => tasksStore
      .query(finder: Finder(filter: Filter.byKey(id)))
      .onSnapshot(db)
      .map((e) =>
          e == null ? null : Task.fromJson(Map.from(e.value)..["id"] = e.key));
}
