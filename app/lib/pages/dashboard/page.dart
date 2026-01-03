import 'package:flow/pages/dashboard/notes.dart';
import 'package:flow/widgets/clock.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
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
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMedium =
                        constraints.maxWidth >= LeapBreakpoints.medium;
                    final textColumn = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: isMedium
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).welcome,
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: isMedium
                              ? TextAlign.start
                              : TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: isMedium
                              ? TextAlign.start
                              : TextAlign.center,
                        ),
                      ],
                    );
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Flex(
                          direction: isMedium ? Axis.horizontal : Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 300,
                                maxHeight: 300,
                              ),
                              child: const AspectRatio(
                                aspectRatio: 1,
                                child: ClockView(),
                              ),
                            ),
                            if (isMedium) const SizedBox(width: 48),
                            if (!isMedium) const SizedBox(height: 24),
                            if (isMedium)
                              Flexible(child: textColumn)
                            else
                              textColumn,
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= LeapBreakpoints.medium) {
                      return SizedBox(
                        height: 400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: DashboardNotesView(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: DashboardEventsView(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: DashboardNotesView(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 400,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: DashboardEventsView(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
