import 'package:flow/widgets/paging/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ErrorIndicatorDisplay extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorIndicatorDisplay({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      icon: const PhosphorIcon(PhosphorIconsLight.warningCircle, size: 30),
      title: AppLocalizations.of(context).indicatorError,
      description: AppLocalizations.of(context).indicatorErrorDescription,
      onTryAgain: onTryAgain,
    );
  }
}
