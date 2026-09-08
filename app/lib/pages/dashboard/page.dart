import 'package:flow/pages/dashboard/notes.dart';
import 'package:flow/widgets/clock.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'events.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return FlowNavigation(
      title: localizations.dashboard,
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
                          localizations.welcome,
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: isMedium
                              ? TextAlign.start
                              : TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                          textAlign: isMedium
                              ? TextAlign.start
                              : TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          alignment: isMedium
                              ? WrapAlignment.start
                              : WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _DashboardAction(
                              label: localizations.calendar,
                              icon: PhosphorIconsLight.calendar,
                              route: '/calendar',
                            ),
                            _DashboardAction(
                              label: localizations.notes,
                              icon: PhosphorIconsLight.listChecks,
                              route: '/notes',
                            ),
                            _DashboardAction(
                              label: localizations.events,
                              icon: PhosphorIconsLight.calendarBlank,
                              route: '/events',
                            ),
                          ],
                        ),
                      ],
                    );
                    return Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: EdgeInsets.all(isMedium ? 32 : 24),
                        child: Flex(
                          direction: isMedium ? Axis.horizontal : Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 240,
                                maxHeight: 240,
                              ),
                              child: const AspectRatio(
                                aspectRatio: 1,
                                child: ClockView(),
                              ),
                            ),
                            if (isMedium) const SizedBox(width: 56),
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

class _DashboardAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;

  const _DashboardAction({
    required this.label,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () => context.go(route),
      icon: PhosphorIcon(icon),
      label: Text(label),
    );
  }
}
