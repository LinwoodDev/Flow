import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shared/models/user.dart';
import 'package:shared/services/local_service.dart';
import 'package:shared/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth.g.dart';

class AuthService {
  @Route.post('/register')
  Future<Response> _register(Request request) async {
    final payload = await request.readAsString();
    final userInfo = json.decode(payload);
    final user = User.fromJson(userInfo);
    final service = GetIt.I.get<LocalService>();
    var errors = <String>[];
    if (user.email.isEmpty) {
      errors.add("email.empty");
    } else if (await service.fetchUserByEmail(user.email) != null) {
      errors.add("email.exist");
    }
    if (user.name.isEmpty) {
      errors.add("name.empty");
    } else if (await service.fetchUserByName(user.name) != null) {
      errors.add("name.exist");
    }
    if (user.password.isEmpty) {
      errors.add("password.empty");
    }
    if (errors.isNotEmpty) return Response(HttpStatus.badRequest, body: json.encode(errors));
    var createdUser = await service
        .createUser(user.copyWith(state: UserState.confirm, password: hashPassword(user.password, generateSalt())));
    return Response.ok(json.encode(createdUser.toJson(addId: true)));
  }

  @Route.post('/login')
  Future<Response> _login(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    return Response.ok(json.encode(user.toJson()));
  }

  Router get router => _$AuthServiceRouter(this);
}
