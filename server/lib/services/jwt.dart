import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared/services/local_service.dart';
import 'package:uuid/uuid.dart';

class JWTService {
  final String secret;
  final String issuer;

  Database get db => GetIt.I.get<LocalService>().db;
  static const String tokensStoreName = 'tokens';
  final tokensStore = intMapStoreFactory.store(tokensStoreName);

  JWTService(this.secret, [this.issuer = "http://localhost"]);

  String generate(String subject) {
    final jwt = JWT({"iat": DateTime.now().millisecondsSinceEpoch},
        subject: subject, issuer: issuer);
    return jwt.sign(SecretKey(secret));
  }
  Future<JWTPair> createPair(String userId) async {
    final tokenId = Uuid().v4();
    final token = generate(userId);

    final refreshTokenExpiry = Duration(seconds: 60);
    final refreshToken = generate(userId);

    await addRefreshToken(tokenId, refreshToken, refreshTokenExpiry);

    return JWTPair(token, refreshToken);
  }


  JWT? verify(String token) {
    try {
      return JWT.verify(token, SecretKey(secret));
    } catch (_) {}
  }

  JWT? handleAuth(String? authHeader) {
    String token;

    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      token = authHeader.substring(7);
      return verify(token);
    }
  }
  Future<void> addRefreshToken(String id, String token, Duration expiry) async {
    await tokensStore.add(db, {"id": id, "token": token, "expire": expiry.inSeconds});
  }

  Future<dynamic> getRefreshToken(String id) async {
    return await tokensStore.findFirst(db, finder: Finder(filter: Filter.equals("token", id))).then((value) => value?.value);
  }

  Future<void> removeRefreshToken(String id) async {
    await tokensStore.delete(db, finder: Finder(filter: Filter.equals("token", id)));
  }
}

class JWTPair {
  final String token, refreshToken;

  JWTPair(this.token, this.refreshToken);

  Map<String, dynamic> toJson() =>
      {"token": token, "refresh-token": refreshToken};
}
