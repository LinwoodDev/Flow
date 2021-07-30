import 'dart:convert';

import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local/service.dart';
import 'package:shared/utils.dart';

import '../server_route.dart';

Future<bool> handleAuthSockets(ServerRoute route) async {
  final service = GetIt.I.get<LocalService>().users;
  final jwtService = GetIt.I.get<JWTService>();

  switch (route.path) {
    case "auth:register":
      try {
        var user = User.fromJson(json.decode(route.value ?? ""));
        var createdUser =
            await service.createUser(user.copyWith(state: UserState.confirm));

        route.reply(value: json.encode(createdUser.toJson(addId: true)));
      } on InputException catch (e) {
        route.reply(exception: e);
      }
      break;
    case "auth:login":
      var user = User.fromJson(json.decode(route.value ?? ""));
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
        return true;
      }
      User? foundUser;
      if (user.email.isNotEmpty) {
        foundUser = await service.fetchUserByEmail(user.email);
      }
      if (user.name.isNotEmpty) {
        foundUser = await service.fetchUserByName(user.name);
      }
      if (foundUser == null ||
          foundUser.password != hashPassword(user.password, foundUser.salt)) {
        route.reply(
            exception: InputException([InputError("credentials.failed")]));
        return true;
      }

      final pair = await jwtService.createPair(foundUser.id!.toRadixString(16));

      route.reply(
          value: (pair.toJson()
            ..addAll({"user": foundUser.toJson(addId: true)})));
      break;
    case "auth:logout":
      final auth = jwtService.verify(route.auth);
      if (auth == null) {
        route.reply(exception: InputException([InputError("unauthorized")]));
        return true;
      }
      try {
        await jwtService.removeRefreshToken(auth.jwtId!);
      } catch (e) {
        route.reply(
            exception: InputException([
          InputError("error", placeholders: [e.toString()])
        ]));
      }
      route.reply();
      break;
    case "auth:refresh-token":
      final token = jwtService.verify(route.value);
      if (token == null) {
        route.reply(
            exception: InputException([InputError("refresh-token.invalid")]));
        return true;
      }

      final dbToken = await jwtService.getRefreshToken(token.jwtId!);
      if (dbToken == null) {
        route.reply(
            exception:
                InputException([InputError("refresh-token.recognized")]));
        return true;
      }

      // Generate new token pair
      try {
        await jwtService.removeRefreshToken(token.jwtId!);

        final tokenPair = await jwtService.createPair(token.subject!);
        route.reply(value: tokenPair.toJson());
      } catch (e) {
        route.reply(
            exception: InputException([
          InputError("refresh-token.error", placeholders: [e.toString()])
        ]));
      }
      break;
    default:
      return false;
  }
  return true;
}
