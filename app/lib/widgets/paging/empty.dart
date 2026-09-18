import 'package:flow/widgets/paging/indicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmptyIndicatorDisplay extends StatelessWidget {
  const EmptyIndicatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return IndicatorDisplay(
      icon: const PhosphorIcon(PhosphorIconsLight.tray, size: 30),
      title: AppLocalizations.of(context).indicatorEmpty,
      description: AppLocalizations.of(context).indicatorEmptyDescription,
    );
  }
}
