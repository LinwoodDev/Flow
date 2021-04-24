import 'dart:convert';

import 'package:shared/models/user.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

part 'session.g.dart';

class SessionService {
  @Route.post('/register')
  Future<Response> _register(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    if (user.password == 'test') return Response.ok(user.toJson());
    return Response.forbidden({'error': 'Password or email is wrong!'});
  }

  @Route.post('/login')
  Future<Response> _login(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    return Response.ok(user);
  }

  Router get router => _$SessionServiceRouter(this);
}
