import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: FlowScaffold(
            bottom: TabBar(tabs: [
              Tab(icon: Icon(PhosphorIcons.squareLight), text: "Opened"),
              Tab(icon: Icon(PhosphorIcons.checkSquareLight), text: "Done")
            ]),
            pageTitle: "Overview",
            page: RoutePages.overview,
            body: TabBarView(children: [Container(), Container()])));
  }
}
