import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared/models/account.dart';

class AccountService {
  final Box _box = Hive.box("settings");
  Account? get account => Account.fromJson(_box.get("account"));
  set account(Account? value) => _box.put("account", value?.toJson());
  Stream<Account?> get accountStream => _box.watch(key: "account").map(
      (event) => event.deleted || event.value == null
          ? null
          : Account.fromJson(event.value));
}
