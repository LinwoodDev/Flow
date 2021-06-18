import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(pageTitle: "Overview", page: RoutePages.overview, body: Container());
  }
}
