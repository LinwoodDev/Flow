import 'package:meta/meta.dart';
import 'package:shared/models/jsonobject.dart';
import 'package:shared/models/user.dart';

@immutable
class Account extends JsonObject {
  final String username;
  final String address;

  Account(this.username, this.address);

  Account.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        address = json['address'] ?? "localhost";

  Account.fromLocalUser(User user)
      : username = user.name,
        address = "localhost";

  @override
  Map<String, dynamic> toJson() => {"username": username, "address": address};

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
