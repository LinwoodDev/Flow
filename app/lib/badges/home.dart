import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/badge.dart';

import 'details.dart';

class BadgesPage extends StatefulWidget {
  @override
  _BadgesPageState createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  Badge? selected = null;
  late ApiService service;
  late Stream<List<Badge>> badgeStream;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
    badgeStream = service.onBadges();
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.badges,
        pageTitle: "Badges",
        actions: [IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight))],
        body: LayoutBuilder(builder: (context, constraints) {
          var isDesktop = MediaQuery.of(context).size.width > 1000;
          return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                if (isDesktop) ...[
                  Expanded(flex: 2, child: BadgePage(isDesktop: isDesktop, id: selected?.id)),
                  VerticalDivider()
                ],
                Expanded(
                    flex: 3,
                    child: Scaffold(
                        floatingActionButton: selected == null && isDesktop
                            ? null
                            : FloatingActionButton.extended(
                                label: Text("Create badge"),
                                icon: Icon(PhosphorIcons.plusLight),
                                onPressed: () => isDesktop
                                    ? setState(() => selected = null)
                                    : Modular.to.pushNamed("/badges/create")),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: StreamBuilder<List<Badge>>(
                                    stream: badgeStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) return Text("Error ${snapshot.error}");
                                      if (snapshot.connectionState == ConnectionState.waiting ||
                                          !snapshot.hasData)
                                        return Center(child: CircularProgressIndicator());
                                      var badges = snapshot.data!;
                                      return Column(
                                          children: List.generate(badges.length, (index) {
                                        var badge = badges[index];
                                        return Dismissible(
                                          key: Key(badge.id!.toString()),
                                          onDismissed: (direction) {
                                            service.deleteBadge(badge.id!);
                                          },
                                          background: Container(color: Colors.red),
                                          child: ListTile(
                                              title: Text(badge.name),
                                              selected: selected?.id == badge.id,
                                              onTap: () => isDesktop
                                                  ? setState(() => selected = badge)
                                                  : Modular.to.pushNamed(Uri(pathSegments: [
                                                      "",
                                                      "badges",
                                                      "details"
                                                    ], queryParameters: {
                                                      "id": badge.id.toString()
                                                    }).toString())),
                                        );
                                      }));
                                    })))))
              ]);
        }));
  }
}
