import 'package:flow/widgets/indicators/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingIndicatorDisplay extends StatelessWidget {
  const LoadingIndicatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      icon: const CircularProgressIndicator(),
      title: AppLocalizations.of(context)!.indicatorLoading,
    );
  }
}
