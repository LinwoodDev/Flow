import 'dart:convert';

import 'package:shared/user.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'session.g.dart';

class SessionService {
  @Route.post('/register')
  Future<Response> _register(Request request) async {
    try {
      var user = User.fromJson(json.decode(await request.readAsString()));
      if (user.password == 'test') return Response.ok(json.encode(user.toJson()));
      return Response.forbidden(json.encode({'error': 'Password or email is wrong!'}));
    } catch (e) {
      return Response.internalServerError(body: json.encode({'error': e.toString()}));
    }
  }

  @Route.post('/login')
  Future<Response> _login(Request request) async {
    var user = User.fromJson(json.decode(await request.readAsString()));
    return Response.ok(json.encode(user.toJson()));
  }

  Router get router => _$SessionServiceRouter(this);
}
