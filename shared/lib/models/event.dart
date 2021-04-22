import 'package:isar/isar.dart';
import 'series.dart';

@Collection()
class Event {
  @Id()
  final int id;
  final String description;
  final series = IsarLink<Series>();
  final EventState state;

  Event(this.id, {this.description, this.state});
}

enum EventState { draft, planned, canceled }
