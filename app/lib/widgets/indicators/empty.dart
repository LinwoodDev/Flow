import 'package:flow/widgets/indicators/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyIndicatorDisplay extends StatelessWidget {
  const EmptyIndicatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      title: AppLocalizations.of(context)!.indicatorEmpty,
      description: AppLocalizations.of(context)!.indicatorEmptyDescription,
    );
  }
}
