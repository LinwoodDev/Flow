import 'dart:convert';
import 'dart:io';

import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/exceptions/input.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local_service.dart';
import 'package:shared/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth.g.dart';

class AuthService {
  final Map<String, Object> jsonHeaders = {HttpHeaders.contentTypeHeader: ContentType.json.mimeType};

  @Route.post('/register')
  Future<Response> _register(Request request) async {
    final payload = await request.readAsString();
    final userInfo = json.decode(payload);
    final user = User.fromJson(userInfo);
    final service = GetIt.I.get<LocalService>();

    try {
      var createdUser = await service.createUser(user.copyWith(state: UserState.confirm));
      return Response.ok(json.encode(createdUser.toJson(addId: true)), headers: jsonHeaders);
    } on InputException catch (e) {
      return Response(HttpStatus.badRequest, body: json.encode(e.toJson()), headers: jsonHeaders);
    }
  }

  @Route.post('/login')
  Future<Response> _login(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    var errors = <String>[];
    if (user.email.isEmpty && user.name.isEmpty) {
      errors.add("name.empty");
    }
    if (user.password.isEmpty) {
      errors.add("password.empty");
    }
    if (errors.isNotEmpty) {
      return Response(HttpStatus.badRequest, body: json.encode(errors), headers: jsonHeaders);
    }
    final service = GetIt.I.get<LocalService>();
    User? foundUser;
    if (user.email.isNotEmpty) foundUser = await service.fetchUserByEmail(user.email);
    if (user.name.isNotEmpty) foundUser = await service.fetchUserByName(user.name);
    if (foundUser == null || foundUser.password != hashPassword(user.password, foundUser.salt)) {
      return Response(HttpStatus.badRequest, body: json.encode(["credentials.failed"]), headers: jsonHeaders);
    }
    final jwtService = GetIt.I.get<JWTService>();

    final token = jwtService.generate(foundUser.id!.toRadixString(16));

    return Response.ok(json.encode({"token": token, "user": foundUser.toJson(addId: true)}), headers: jsonHeaders);
  }

  Router get router => _$AuthServiceRouter(this);
}
