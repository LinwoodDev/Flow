import 'package:meta/meta.dart';

@immutable
class Place {
  final int? id;
  final String name;

  Place(this.name, {this.id});
  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
