import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BadgesPage extends StatefulWidget {
  @override
  _BadgesPageState createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.badges,
        pageTitle: "Badges",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        floatingActionButton: FloatingActionButton.extended(
            label: Text("Create badge"),
            icon: Icon(PhosphorIcons.plusLight),
            onPressed: () => Modular.to.pushNamed("/badges/create")),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(
                    children: List.generate(10,
                        (index) => ListTile(title: Text((index + 1).toString()), onTap: () {}))))));
  }
}
