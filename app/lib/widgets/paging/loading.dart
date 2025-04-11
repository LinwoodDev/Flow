import 'package:flow/widgets/paging/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';

class LoadingIndicatorDisplay extends StatelessWidget {
  const LoadingIndicatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      icon: const CircularProgressIndicator(),
      title: AppLocalizations.of(context).indicatorLoading,
    );
  }
}
