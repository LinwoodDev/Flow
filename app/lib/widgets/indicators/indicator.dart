import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IndicatorDisplay extends StatelessWidget {
  final Widget? icon;
  final String? title, description;
  final VoidCallback? onTryAgain;

  const IndicatorDisplay({
    super.key,
    this.title,
    this.icon,
    this.description,
    this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          const SizedBox(height: 8),
          if (description != null)
            Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (onTryAgain != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                onPressed: onTryAgain,
                label: Text(
                  AppLocalizations.of(context).tryAgain,
                ),
                icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
              ),
            ),
        ],
      ),
    );
  }
}
