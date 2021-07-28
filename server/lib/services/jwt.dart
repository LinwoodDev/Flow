import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

class JWTService {
  final String secret;
  final String issuer;

  JWTService(this.secret, [this.issuer = "http://localhost"]);

  String generate(String subject) {
    final jwt = JWT({"iat": DateTime.now().millisecondsSinceEpoch},
        subject: subject, issuer: issuer);
    return jwt.sign(SecretKey(secret));
  }

  JWT? verify(String token) {
    try {
      return JWT.verify(token, SecretKey(secret));
    } catch (_) {}
  }

  Middleware handleAuth() {
    return (Handler innerHandler) {
      return (Request request) async {
        final authHeader = request.headers['authorization'];
        String token;
        JWT? jwt;

        if (authHeader != null && authHeader.startsWith('Bearer ')) {
          token = authHeader.substring(7);
          jwt = verify(token);
        }
        final updatedRequest = request.change(context: {'authDetails': jwt});
        return await innerHandler(updatedRequest);
      };
    };
  }

  Middleware checkAuthorization() {
    return createMiddleware(
      requestHandler: (request) {
        if (request.context['authDetails'] == null) {
          return Response.forbidden(json.encode(["unauthorized"]), headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType
          });
        }
        return null;
      },
    );
  }
}
