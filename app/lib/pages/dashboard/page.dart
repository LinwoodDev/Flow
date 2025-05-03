import 'package:flow/pages/dashboard/notes.dart';
import 'package:flow/widgets/clock.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/helpers.dart';

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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            minHeight: 300,
                            minWidth: 300,
                            maxWidth: 600,
                            maxHeight: 600),
                        child: const ClockView(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context).welcome,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth >= LeapBreakpoints.medium) {
                          return SizedBox(
                            height: 250,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8,
                              children: [
                                Expanded(child: DashboardNotesView()),
                                const VerticalDivider(),
                                Expanded(child: DashboardEventsView()),
                              ],
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 250,
                                  minWidth: 300,
                                  maxWidth: 600,
                                  maxHeight: 300,
                                ),
                                child: DashboardNotesView()),
                            const Divider(),
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: 250,
                                  minWidth: 300,
                                  maxWidth: 600,
                                  maxHeight: 300,
                                ),
                                child: DashboardEventsView()),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
