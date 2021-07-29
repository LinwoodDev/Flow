import 'dart:async';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/services/local_service.dart';

import '../server_route.dart';

Future<void> handleUserSockets(ServerRoute route) async {
  final service = GetIt.I.get<LocalService>();
  final jwtService = GetIt.I.get<JWTService>();

  final token = jwtService.verify(route.auth);
  if(route.path.startsWith("user") && token?.subject == null) {
    route.reply(exception: InputException([InputError("unauthorized")]));
    return;
  }
  final user = await service.fetchUser(int.parse(token!.subject!, radix: 16));
  switch(route.path) {
    case "user:info":
      route.reply(value: user?.toJson(addId: true));
      break;
  }
/*
    return _buildPipeline(request, (request) async {
      var authDetails = request.context["authDetails"] as JWT;
      var id = int.parse(authDetails.subject!, radix: 16);
      var user = await GetIt.I.get<LocalService>().fetchUser(id);
      return Response.ok(json.encode(user?.toJson(addId: true)), headers: jsonHeaders);
    });*/
}
