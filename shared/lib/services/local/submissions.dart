import 'package:sembast/sembast.dart';
import 'package:shared/models/task.dart';
import 'package:shared/services/api_service.dart';

class SubmissionsLocalService extends SubmissionsApiService {
  final Database db;
  static const String submissionsStoreName = 'submissions';
  final submissionsStore = intMapStoreFactory.store(submissionsStoreName);

  SubmissionsLocalService(this.db);

  @override
  Future<List<Submission>> fetchSubmissions(int task,
          {SubmissionState? state}) =>
      submissionsStore
          .find(db,
              finder: Finder(
                  filter: Filter.and([
                if (state != null) Filter.equals("state", state),
                Filter.equals("task", task)
              ])))
          .then((value) => value
              .map(
                  (e) => Submission.fromJson(Map.from(e.value)..["id"] = e.key))
              .toList());

  @override
  Future<int> fetchSubmissionsCount(int task, {SubmissionState? state}) =>
      submissionsStore.count(db,
          filter: Filter.and([
            if (state != null) Filter.equals("state", state),
            Filter.equals("task", task)
          ]));

  @override
  Future<Submission?> fetchSubmission(int task, int user) => submissionsStore
      .findFirst(db,
          finder: Finder(
              filter: Filter.and(
                  [Filter.equals("task", task), Filter.equals("user", user)])))
      .then((value) => value == null
          ? null
          : Submission.fromJson(Map.from(value.value)..["id"] = value.key));

  @override
  Stream<List<Submission>> onSubmissions(int task, {SubmissionState? state}) =>
      submissionsStore
          .query(
              finder: Finder(
                  filter: Filter.and([
            if (state != null) Filter.equals("state", state),
            Filter.equals("task", task)
          ])))
          .onSnapshots(db)
          .map((submissions) => submissions
              .map(
                  (e) => Submission.fromJson(Map.from(e.value)..["id"] = e.key))
              .toList());

  @override
  Stream<Submission?> onSubmission(int task, int user) => submissionsStore
      .query(
          finder: Finder(
              filter: Filter.and(
                  [Filter.equals("task", task), Filter.equals("user", user)])))
      .onSnapshot(db)
      .map((e) => e == null
          ? null
          : Submission.fromJson(Map.from(e.value)..["id"] = e.key));

  @override
  Future<void> createSubmission(Submission submission) => submissionsStore
      .add(db, submission.toJson())
      .then((value) => submission.copyWith(id: value));

  @override
  Future<void> deleteSubmission(int id) =>
      submissionsStore.delete(db, finder: Finder(filter: Filter.byKey(id)));

  @override
  Future<void> updateSubmission(Submission submission) =>
      submissionsStore.update(db, submission.toJson(),
          finder: Finder(filter: Filter.byKey(submission.id)));
}
