import 'package:flow_app/badges/details.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/badge.dart';

class BadgesPage extends StatefulWidget {
  @override
  _BadgesPageState createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  int? selected = null;
  final List<Badge> badges = [Badge("Badge 1"), Badge("Badge 2"), Badge("Badge 3")];

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.badges,
        pageTitle: "Badges",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    label: Text("Create badge"),
                    icon: Icon(PhosphorIcons.plusLight),
                    onPressed: () => Modular.to.pushNamed("/badges/create")),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                badges.length,
                                (index) => ListTile(
                                    title: Text(badges[index].name),
                                    selected: selected == index,
                                    onTap: () => isDesktop
                                        ? setState(() => selected = index)
                                        : Modular.to.pushNamed(Uri(
                                                pathSegments: ["", "badges", "details"],
                                                queryParameters: {"id": index.toString()})
                                            .toString())))))),
              ),
            ),
            if (isDesktop) ...[
              VerticalDivider(),
              Expanded(
                  flex: 2,
                  child: selected == null
                      ? Center(child: Text("Nothing selected"))
                      : BadgePage(badge: badges[selected!], isDesktop: isDesktop, id: selected!))
            ]
          ]);
        }));
  }
}
