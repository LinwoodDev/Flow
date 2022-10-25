import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.calendar,
      selected: "calendar",
      bottom: TabBar(controller: _tabController, tabs: [
        Tab(
          text: AppLocalizations.of(context)!.today,
          icon: const Icon(Icons.calendar_today_outlined),
        ),
        Tab(
          text: AppLocalizations.of(context)!.groups,
          icon: const Icon(Icons.folder_outlined),
        )
      ]),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(),
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
