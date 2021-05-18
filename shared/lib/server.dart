import 'package:meta/meta.dart';

@immutable
class Server {
  final int id;
  final String? address;
  final String? accessToken;
  final String? username;
  final String? refreshToken;

  Server(this.id, {this.address, this.accessToken, this.username, this.refreshToken});

  Server copyWith({String? address, String? accessToken, String? username, String? refreshToken}) =>
      Server(id,
          accessToken: accessToken ?? this.accessToken,
          address: address ?? this.address,
          refreshToken: refreshToken ?? this.refreshToken,
          username: username ?? this.username);
}
