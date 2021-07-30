class DevDoctorConfig {
  final bool isEnabled;

  const DevDoctorConfig({this.isEnabled = true});

  DevDoctorConfig.fromJson(Map<String, dynamic> json) : isEnabled = json['enabled'];

  DevDoctorConfig copyWith({bool? isEnabled}) =>
      DevDoctorConfig(isEnabled: isEnabled ?? this.isEnabled);

  Map<String, dynamic> toJson() => {"enabled": isEnabled};
}