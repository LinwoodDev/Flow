class EventConfig {
  final bool isEnabled;

  const EventConfig({this.isEnabled = true});

  EventConfig.fromJson(Map<String, dynamic> json) : isEnabled = json['enabled'];

  EventConfig copyWith({bool? isEnabled}) =>
      EventConfig(isEnabled: isEnabled ?? this.isEnabled);

  Map<String, dynamic> toJson() => {"enabled": isEnabled};
}
