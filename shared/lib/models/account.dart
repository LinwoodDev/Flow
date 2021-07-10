import 'package:equatable/equatable.dart';
import 'package:shared/models/user.dart';

class Account extends Equatable {
  String username;
  String address;

  Account(this.username, this.address);

  Account.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        address = json['address'] ?? "localhost";

  Account.fromLocalUser(User user)
      : username = user.name,
        address = "localhost";

  Map<String, dynamic> toJson() => {"username": username, "address": address};

  @override
  String toString() {
    return "$username@$address";
  }

  @override
  List<Object?> get props => [toString()];
}
