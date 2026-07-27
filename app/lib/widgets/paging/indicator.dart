import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
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
    final theme = Theme.of(context);
    return Semantics(
      container: true,
      liveRegion: true,
      label: [title, description].whereType<String>().join('. '),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 64,
                      child: Center(child: icon),
                    ),
                  ),
                if (icon != null && title != null) const SizedBox(height: 20),
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                if (description != null) const SizedBox(height: 8),
                if (description != null)
                  Text(
                    description!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (onTryAgain != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FilledButton.tonalIcon(
                      onPressed: onTryAgain,
                      label: Text(AppLocalizations.of(context).tryAgain),
                      icon: const PhosphorIcon(
                        PhosphorIconsLight.arrowClockwise,
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
