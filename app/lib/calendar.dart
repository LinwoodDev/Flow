import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    Key forwardListKey = UniqueKey();
    Widget forwardList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          color: index % 2 != 0 ? Colors.green : Colors.yellow,
          child: Text('fordward $index'),
          height: 100.0,
        );
      }),
      key: forwardListKey,
    );

    Widget reverseList = SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          color: index % 2 == 0 ? Colors.green : Colors.yellow,
          child: Text('reverse $index'),
          height: 100.0,
        );
      }),
    );

    return FlowScaffold(
        pageTitle: "Calendar",
        page: RoutePages.calendar,
        body: Scrollbar(
          child: Scrollable(viewportBuilder: (context, offset) {
            return Viewport(offset: offset, center: forwardListKey, slivers: [
              reverseList,
              forwardList,
            ]);
          }),
        ));
    //return FlowScaffold(pageTitle: "Calendar", page: RoutePages.calendar, body: Container());
  }
}
