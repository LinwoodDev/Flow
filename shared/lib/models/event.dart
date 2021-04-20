import 'package:isar/isar.dart';
import 'series.dart';

class Event {
  @Id()
  final int id;
  final series = IsarLink<Series>();
  final EventState state;

  Event(this.id, {this.state});
}

enum EventState { draft, planned, canceled }
