import 'package:shared/config/dev_doctor.dart';
import 'package:shared/config/event.dart';
import 'package:shared/config/task.dart';
import 'package:shared/config/team.dart';

class MainConfig {
  final EventConfig event;
  final TaskConfig task;
  final TeamConfig team;
  final DevDoctorConfig devDoctor;

  MainConfig(
      {this.event = const EventConfig(),
      this.task = const TaskConfig(),
      this.team = const TeamConfig(),
      this.devDoctor = const DevDoctorConfig()});

  MainConfig.fromJson(Map<String, dynamic> json)
      : event = EventConfig.fromJson(json['event']),
        task = TaskConfig.fromJson(json['task']),
        team = TeamConfig.fromJson(json['team']),
        devDoctor = DevDoctorConfig.fromJson(json['dev-doctor']);

  Map<String, dynamic> toJson() => {
        "event": event.toJson(),
        "task": task.toJson(),
        "team": team.toJson(),
        "dev-doctor": devDoctor.toJson()
      };

  MainConfig copyWith(
          {EventConfig? event,
          TaskConfig? task,
          TeamConfig? team,
          DevDoctorConfig? devDoctor}) =>
      MainConfig(
          event: event ?? this.event,
          task: task ?? this.task,
          team: team ?? this.team,
          devDoctor: devDoctor ?? this.devDoctor);
}
