import 'package:meta/meta.dart';

@immutable
class Task {
  final int? id;
  final String name;
  final String description;

  Task(this.name, {this.id, this.description = ''});
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'] ?? '';
  Map<String, dynamic> toJson() => {'name': name, 'description': description};
  Task copyWith({String? name, String? description, int? id}) =>
      Task(name ?? this.name, description: description ?? this.description, id: id ?? this.id);
}
