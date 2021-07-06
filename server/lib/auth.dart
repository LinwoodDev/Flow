import 'dart:convert';
import 'dart:io';

import 'package:shared/models/user.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'auth.g.dart';

class AuthService {
  @Route.post('/register')
  Future<Response> _register(Request request) async {
    final payload = await request.readAsString();
    final userInfo = json.decode(payload);
    final user = User.fromJson(userInfo);
    if (user.email.isEmpty || user.password.isEmpty) {
      return Response(HttpStatus.badRequest, body: "Please provide your email and password");
    }

    return Response.ok("Register endpoint");
  }

  @Route.post('/login')
  Future<Response> _login(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    return Response.ok(json.encode(user.toJson()));
  }

  Router get router => _$SessionServiceRouter(this);
}
