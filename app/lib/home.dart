import 'package:flow_app/widgets/color_picker.dart';
import 'package:flutter/material.dart';

import 'widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
        page: RoutePages.home, pageTitle: "Home", body: ColorPicker(onClick: (color) {}));
  }
}
