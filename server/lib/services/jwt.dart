import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JWTService {
  final String secret;
  final String issuer;

  JWTService(this.secret, [this.issuer = "http://localhost"]);

  String generate(String subject) {
    final jwt = JWT({"iat": DateTime.now().millisecondsSinceEpoch}, subject: subject, issuer: issuer);
    return jwt.sign(SecretKey(secret));
  }

  JWT? verify(String token) {
    try {
      return JWT.verify(token, SecretKey(secret));
    } catch (_) {}
  }
}
