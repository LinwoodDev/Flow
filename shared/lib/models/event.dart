import 'package:meta/meta.dart';
import 'package:shared/models/assign.dart';

import 'jsonobject.dart';

@immutable
class Event extends JsonObject {
  final int? id;
  final String name;
  final String description;
  final int? season;
  final bool isCanceled;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final Assigned assigned;
  final int? parent;

  Event(this.name,
      {this.description = '',
      this.id,
      this.parent,
      this.season,
      this.startDateTime,
      this.endDateTime,
      this.assigned = const Assigned(),
      this.isCanceled = false});

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'],
        parent = json['parent'],
        description = json['description'] ?? '',
        startDateTime = DateTime.tryParse(json['start-date-time'] ?? ''),
        endDateTime = DateTime.tryParse(json['end-date-time'] ?? ''),
        season = json['season'],
        isCanceled = json['canceled'] ?? false,
        assigned = Assigned.fromJson(json['assigned'] ?? {});

  @override
  Map<String, dynamic> toJson({bool addId = false}) => {
        'parent': parent,
        'description': description,
        'canceled': isCanceled,
        'start-date-time': startDateTime?.toString(),
        'end-date-time': endDateTime?.toString(),
        'season': season,
        'name': name,
        'assigned': assigned.toJson()
      }..addAll(addId ? {'id': id} : {});

  @override
  Event copyWith(
          {String? name,
          String? description,
          int? season,
          int? parent,
          bool? isCanceled,
          DateTime? startDateTime,
          DateTime? endDateTime,
          bool removeSeason = false,
          bool removeStartDateTime = false,
          bool removeEndDateTime = false,
          bool removeParent = false,
          int? id,
          Assigned? assigned}) =>
      Event(name ?? this.name,
          description: description ?? this.description,
          id: id ?? this.id,
          parent: removeParent ? null : (parent ?? this.parent),
          season: removeSeason ? null : (season ?? this.season),
          startDateTime: removeStartDateTime
              ? null
              : (startDateTime ?? this.startDateTime),
          endDateTime:
              removeEndDateTime ? null : (endDateTime ?? this.endDateTime),
          isCanceled: isCanceled ?? this.isCanceled,
          assigned: assigned ?? this.assigned);

  @override
  List<Object?> get props => [id];
}
