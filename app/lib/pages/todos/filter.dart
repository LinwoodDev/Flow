part of 'page.dart';

class _TodoFilterDialog extends StatelessWidget {
  const _TodoFilterDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.filter),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [],
      ),
    );
  }
}
