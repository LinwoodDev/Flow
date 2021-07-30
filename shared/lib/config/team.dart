class TeamConfig {
  final bool isEnabled;

  const TeamConfig({this.isEnabled = true});

  TeamConfig.fromJson(Map<String, dynamic> json) : isEnabled = json['enabled'];

  TeamConfig copyWith({bool? isEnabled}) =>
      TeamConfig(isEnabled: isEnabled ?? this.isEnabled);

  Map<String, dynamic> toJson() => {"enabled": isEnabled};
}
