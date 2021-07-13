import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flow_server/services/jwt.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/services/local_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'profile.g.dart';

class ProfileService {
  final Map<String, Object> jsonHeaders = {HttpHeaders.contentTypeHeader: ContentType.json.mimeType};

  JWTService get jwtService => GetIt.I.get<JWTService>();

  @Route.get("/")
  FutureOr<Response> _info(Request request) {
    return _buildPipeline(request, (request) async {
      var authDetails = request.context["authDetails"] as JWT;
      var id = int.parse(authDetails.subject!, radix: 16);
      var user = await GetIt.I.get<LocalService>().fetchUser(id);
      return Response.ok(json.encode(user?.toJson(addId: true)), headers: jsonHeaders);
    });
  }

  FutureOr<Response> _buildPipeline(Request request, Handler handler) =>
      Pipeline().addMiddleware(jwtService.checkAuthorization()).addHandler(handler)(request);

  Router get router => _$ProfileServiceRouter(this);
}
