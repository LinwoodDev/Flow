import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';

class AccountsSettingsPage extends StatefulWidget {
  const AccountsSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountsSettingsPageState createState() => _AccountsSettingsPageState();
}

class _AccountsSettingsPageState extends State<AccountsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.accounts,
        pageTitle: "Accounts",
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Modular.to.pushNamed("/connect"),
            label: const Text("Add account"),
            icon: const Icon(PhosphorIcons.plusLight)),
        body: ValueListenableBuilder<Box>(
            valueListenable: Hive.box('accounts').listenable(),
            builder: (context, box, _) {
              var accounts = box.values.map((e) => Account.fromJson(e)).toList();
              return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    var current = accounts[index];
                    return Dismissible(
                      background: Container(color: Colors.red),
                      key: Key(box.getAt(index) ?? ""),
                      onDismissed: (direction) => box.deleteAt(index),
                      child: ListTile(
                          title: Text(current.toString()),
                          subtitle: Text(box.getAt(index) ?? ""),
                          trailing: IconButton(icon: const Icon(PhosphorIcons.signOutLight), onPressed: () {})),
                    );
                  });
            }));
  }
}
