import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/account.dart';

class AccountsDialog extends StatefulWidget {
  const AccountsDialog({Key? key}) : super(key: key);

  @override
  _AccountsDialogState createState() => _AccountsDialogState();
}

class _AccountsDialogState extends State<AccountsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("Assign"),
                  leading: const Icon(PhosphorIcons.compassLight),
                ),
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...[
                        Account("test", "example.com"),
                        Account("test2", "example.com")
                      ].map((e) => ListTile(
                          title: Text(e.username), subtitle: Text(e.address)))
                    ]))));
  }
}
