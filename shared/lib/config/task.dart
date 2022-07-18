class TaskConfig {
  final bool isEnabled;

  const TaskConfig({this.isEnabled = true});

  TaskConfig.fromJson(Map<String, dynamic> json) : isEnabled = json['enabled'];

  TaskConfig copyWith({bool? isEnabled}) =>
      TaskConfig(isEnabled: isEnabled ?? this.isEnabled);

  Map<String, dynamic> toJson() => {"enabled": isEnabled};
}
