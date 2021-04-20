import 'package:isar/isar.dart';

class Place {
  @Id()
  final int id;
  final String name;

  Place(this.id, {this.name});
}
