import 'dart:convert';

import 'package:shared/exceptions/input.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketPackage {
  final String route;
  final InputException? exception;
  final String? auth;
  final dynamic value;

  SocketPackage(
      {required this.route, this.exception, required this.value, this.auth});

  SocketPackage.fromJson(Map<String, dynamic> json)
      : route = json['route'],
        auth = json['auth'],
        exception = json.containsKey('exception')
            ? InputException.fromJson(json['exception'])
            : null,
        value = json['data'];

  bool get hasAuth => auth != null;

  bool get hasException => exception != null;

  bool get hasData => value != null;

  Map<String, dynamic> toJson() =>
      {"route": route, "exception": exception?.toJson(), "data": value};

  Future<SocketPackage> send(WebSocketChannel channel) {
    submit(channel);
    return channel.stream
        .firstWhere((element) => element['route'] == route)
        .then((value) => SocketPackage.fromJson(json.decode(value)));
  }

  Future<void> submit(WebSocketChannel channel) {
    channel.sink.add(json.encode(toJson()));
    return channel.sink.done;
  }
}
