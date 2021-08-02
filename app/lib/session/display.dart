import 'package:flutter/material.dart';
import 'package:shared/config/main.dart';
import 'package:shared/models/account.dart';

class SessionDisplay extends StatelessWidget {
  final MainConfig mainConfig;
  final Account? account;

  const SessionDisplay({Key? key, required this.mainConfig, this.account})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(mainConfig.name, style: Theme.of(context).textTheme.headline5),
      Text(mainConfig.description,
          style: Theme.of(context).textTheme.subtitle2),
      if (account != null) ...[
        const VerticalDivider(),
        Text(account.toString())
      ]
    ]);
  }
}
