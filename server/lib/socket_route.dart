import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/socket_package.dart';

class SocketRoute {
  final ServerSocket serverSocket;
  final Socket socket;
  final SocketPackage package;

  SocketRoute(this.serverSocket, this.socket, this.package);

  String get path => package.route;

  dynamic get value => package.value;

  void reply({InputException? exception, dynamic value}) => socket.write(
      SocketPackage(route: path, exception: exception, value: value).toJson());

  void broadcast({InputException? exception, dynamic value}) => GetIt.I
      .get<List<Socket>>(instanceName: 'sockets')
      .forEach((element) => element.write(
          SocketPackage(route: path, exception: exception, value: value)
              .toJson()));
}
