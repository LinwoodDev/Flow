import 'package:isar/isar.dart';

class Server {
  @Id()
  late int id = 0;
  late String? address;
  late String? accessToken;
  late String? username;
  late String? refreshToken;

  Server();
  Server.fromValue(this.id, {this.address, this.accessToken, this.username, this.refreshToken});

  Server copyWith({String? address, String? accessToken, String? username, String? refreshToken}) =>
      Server()
        ..id = id
        ..accessToken = accessToken ?? this.accessToken
        ..address = address ?? this.address
        ..refreshToken = refreshToken ?? this.refreshToken
        ..username = username ?? this.username;
}
