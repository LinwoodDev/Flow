import 'dart:convert';

import 'package:flow_server/services/jwt.dart';
import 'package:flow_server/socket_route.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local_service.dart';
import 'package:shared/utils.dart';

Future<void> handleAuthSockets(SocketRoute route) async {
  var service = GetIt.I.get<LocalService>();
  switch (route.path) {
    case "auth:register":
      try {
        var user = User.fromJson(route.value);
        var createdUser =
            await service.createUser(user.copyWith(state: UserState.confirm));

        route.reply(value: json.encode(createdUser.toJson(addId: true)));
      } on InputException catch (e) {
        route.reply(exception: e);
      }
      break;
    case "auth:login":
      var user = User.fromJson(route.value);
      var errors = <String>[];
      if (user.email.isEmpty && user.name.isEmpty) {
        errors.add("name.empty");
      }
      if (user.password.isEmpty) {
        errors.add("password.empty");
      }
      if (errors.isNotEmpty) {
        route.reply(
            exception:
                InputException(errors.map((e) => InputError(e)).toList()));
        return;
      }
      final service = GetIt.I.get<LocalService>();
      User? foundUser;
      if (user.email.isNotEmpty)
        foundUser = await service.fetchUserByEmail(user.email);
      if (user.name.isNotEmpty)
        foundUser = await service.fetchUserByName(user.name);
      if (foundUser == null ||
          foundUser.password != hashPassword(user.password, foundUser.salt)) {
        route.reply(
            exception: InputException([InputError("credentials.failed")]));
        return;
      }
      final jwtService = GetIt.I.get<JWTService>();

      final token = jwtService.generate(foundUser.id!.toRadixString(16));

      route.reply(
          value: ({"token": token, "user": foundUser.toJson(addId: true)}));
  }
}
