import 'package:shared/config/dev_doctor.dart';
import 'package:shared/config/event.dart';
import 'package:shared/config/task.dart';
import 'package:shared/config/team.dart';

class MainConfig {
  final EventConfig event;
  final TaskConfig task;
  final TeamConfig team;
  final String name, description;
  final DevDoctorConfig devDoctor;

  MainConfig(
      {this.name = "",
      this.description = "",
      this.event = const EventConfig(),
      this.task = const TaskConfig(),
      this.team = const TeamConfig(),
      this.devDoctor = const DevDoctorConfig()});

  MainConfig.fromJson(Map<String, dynamic> json)
      : event = json['event'] != null
            ? EventConfig.fromJson(json['event'])
            : EventConfig(
                isEnabled:
                    (json['modules'] as List<dynamic>?)?.contains('events') ??
                        true),
        task = json['task'] != null
            ? TaskConfig.fromJson(json['task'])
            : TaskConfig(
                isEnabled:
                    (json['modules'] as List<dynamic>?)?.contains('tasks') ??
                        true),
        team = json['team'] != null
            ? TeamConfig.fromJson(json['team'])
            : TeamConfig(
                isEnabled:
                    (json['modules'] as List<dynamic>?)?.contains('teams') ??
                        true),
        devDoctor = json['dev-doctor'] != null
            ? DevDoctorConfig.fromJson(json['dev-doctor'])
            : DevDoctorConfig(
                isEnabled: (json['modules'] as List<dynamic>?)
                        ?.contains('dev-doctor') ??
                    true),
        name = json['name'] ?? '',
        description = json['description'] ?? '';

  Map<String, dynamic> toJson({bool limited = false}) =>
      {"name": name, "description": description}..addAll(limited
          ? {
              "modules": [
                if (event.isEnabled) "events",
                if (task.isEnabled) "tasks",
                if (team.isEnabled) "teams",
                if (devDoctor.isEnabled) "dev-doctor"
              ]
            }
          : {
              "event": event.toJson(),
              "task": task.toJson(),
              "team": team.toJson(),
              "dev-doctor": devDoctor.toJson(),
            });

  MainConfig copyWith(
          {EventConfig? event,
          TaskConfig? task,
          TeamConfig? team,
          DevDoctorConfig? devDoctor,
          String? name,
          String? description}) =>
      MainConfig(
          event: event ?? this.event,
          task: task ?? this.task,
          team: team ?? this.team,
          devDoctor: devDoctor ?? this.devDoctor,
          name: name ?? this.name,
          description: description ?? this.description);
}
