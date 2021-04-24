import 'package:isar/isar.dart';

class Server {
  @Id()
  final int id;
  final String? address;
  final String? accessToken;
  final String? username;
  final DateTime? added;
  final String? refreshToken;

  Server(this.id, {this.address, this.accessToken, this.username, this.added, this.refreshToken});

  Server copyWith({String? address, String? accessToken, String? username, String? refreshToken}) =>
      Server(id,
          accessToken: accessToken ?? this.accessToken,
          added: added,
          address: address ?? this.address,
          refreshToken: refreshToken ?? this.refreshToken,
          username: username ?? this.username);
}
