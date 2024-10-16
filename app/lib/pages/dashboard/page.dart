import 'package:flow/pages/dashboard/notes.dart';
import 'package:flow/widgets/clock.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'events.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).dashboard,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minHeight: 300,
                        minWidth: 300,
                        maxWidth: 600,
                        maxHeight: 600),
                    child: const ClockView(),
                  ),
                )),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context).welcome,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                )),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const DashboardNotesCard(),
                    const DashboardEventsCard(),
                  ]
                      .map((e) => ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: e,
                            )),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
