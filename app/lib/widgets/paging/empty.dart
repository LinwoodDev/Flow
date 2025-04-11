import 'package:flow/widgets/paging/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';

class EmptyIndicatorDisplay extends StatelessWidget {
  const EmptyIndicatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      title: AppLocalizations.of(context).indicatorEmpty,
      description: AppLocalizations.of(context).indicatorEmptyDescription,
    );
  }
}
