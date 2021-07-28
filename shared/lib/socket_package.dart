import 'package:shared/exceptions/input.dart';

class SocketPackage {
  final String route;
  final InputException? exception;
  final dynamic value;

  SocketPackage({required this.route, this.exception, required this.value});

  SocketPackage.fromJson(Map<String, dynamic> json)
      : route = json['route'],
        exception = InputException.fromJson(json['exception']),
        value = json['data'];

  bool get hasException => exception != null;

  bool get hasData => value != null;

  Map<String, dynamic> toJson() =>
      {"route": route, "exception": exception?.toJson(), "data": value};
}
