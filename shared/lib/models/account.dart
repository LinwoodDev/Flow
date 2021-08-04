import 'package:meta/meta.dart';
import 'package:shared/models/json_object.dart';
import 'package:shared/models/user.dart';

@immutable
class Account extends JsonObject {
  final String username;
  final String address;
  final String token, refreshToken;
  final DateTime? expired;

  Account(this.username, this.address,
      {this.token = "", this.refreshToken = "", this.expired});

  Account.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        address = json['address'] ?? "localhost",
        token = json['token'] ?? '',
        refreshToken = json['refresh-token'] ?? '',
        expired = json.containsKey('expired')
            ? DateTime.tryParse(json['expired'])
            : null;

  Account.fromLocalUser(User user)
      : username = user.name,
        address = "localhost",
        token = '',
        refreshToken = '',
        expired = null;

  @override
  Map<String, dynamic> toJson({bool secrets = false}) =>
      {"username": username, "address": address}..addAll(secrets
          ? {
              "token": token,
              "refresh-token": refreshToken,
              "expired": expired.toString()
            }
          : {});

  @override
  String toString() {
    return "$username@$address";
  }

  @override
  List<Object?> get props => [toString()];

  @override
  Account copyWith({String? username, String? address}) =>
      Account(username ?? this.username, address ?? this.address);
}
