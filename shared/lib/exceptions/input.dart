class InputException implements Exception {
  final List<InputError> errors;

  InputException(this.errors);

  InputException.fromJson(List<dynamic> json)
      : errors = json.map((e) => InputError.fromJson(e)).toList();

  List<dynamic> toJson() => errors.map((e) => e.toJson()).toList();
}

class InputError {
  final String translationKey;
  final List<String> placeholders;

  InputError(this.translationKey, {this.placeholders = const []});

  InputError.fromJson(dynamic json)
      : translationKey = json is Map ? json['key'] : json,
        placeholders = json is Map ? json['placeholders'] ?? [] : [];

  dynamic toJson() {
    if (placeholders.isEmpty) return translationKey;
    return {"key": translationKey, "placeholders": placeholders};
  }

  @override
  String toString() => translationKey;
}
