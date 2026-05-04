import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CalDavSourceDialog extends StatefulWidget {
  const CalDavSourceDialog({super.key});

  @override
  State<CalDavSourceDialog> createState() => _CalDavSourceDialogState();
}

class _CalDavSourceDialogState extends State<CalDavSourceDialog> {
  final TextEditingController _urlController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("CalDAV"),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).url,
                icon: const PhosphorIcon(PhosphorIconsLight.globe),
                border: const OutlineInputBorder(),
              ),
              controller: _urlController,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).username,
                icon: const PhosphorIcon(PhosphorIconsLight.user),
                filled: true,
              ),
              controller: _usernameController,
            ),
            const SizedBox(height: 8),
            StatefulBuilder(
              builder: (context, setState) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).password,
                    icon: const PhosphorIcon(PhosphorIconsLight.lock),
                    filled: true,
                    suffix: IconButton(
                      icon: PhosphorIcon(
                        _showPassword
                            ? PhosphorIconsLight.lockOpen
                            : PhosphorIconsLight.lock,
                      ),
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                    ),
                  ),
                  obscureText: !_showPassword,
                  controller: _passwordController,
                  keyboardType: _showPassword
                      ? TextInputType.visiblePassword
                      : null,
                  enableSuggestions: false,
                  autocorrect: false,
                );
              },
            ),
          ],
        ),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            await context.read<SourcesService>().addRemote(
              CalDavStorage(
                url: _urlController.text,
                username: _usernameController.text,
              ),
              _passwordController.text,
            );
            if (mounted) navigator.pop();
          },
          child: Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
