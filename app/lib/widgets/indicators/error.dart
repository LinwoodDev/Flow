import 'package:flow/widgets/indicators/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorIndicatorDisplay extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorIndicatorDisplay({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      title: AppLocalizations.of(context)!.indicatorError,
      description: AppLocalizations.of(context)!.indicatorErrorDescription,
      onTryAgain: onTryAgain,
    );
  }
}
