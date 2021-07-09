class Account {
  String username;
  String address;

  Account(this.username, this.address);

  Account.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        address = json['address'];

  Map<String, dynamic> toJson() => {"username": username, "address": address};

  @override
  String toString() {
    return "$username@$address";
  }
}
