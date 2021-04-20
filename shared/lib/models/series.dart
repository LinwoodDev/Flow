import 'package:isar/isar.dart';

class Series {
  @Id()
  final int id;
  final String name;
  final int color;
  final String description;

  Series({this.description, this.id, this.color, this.name});
}
