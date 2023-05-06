import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ICalSourceDialog extends StatelessWidget {
  final TextEditingController _urlController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController();
  ICalSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    bool showPassword = false;
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
            StatefulBuilder(builder: (context, setState) {
              return TextFormField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).password,
                    icon: const PhosphorIcon(PhosphorIconsLight.lock),
                    filled: true,
                    suffix: IconButton(
                        icon: PhosphorIcon(showPassword
                            ? PhosphorIconsLight.lockOpen
                            : PhosphorIconsLight.lock),
                        onPressed: () =>
                            setState(() => showPassword = !showPassword))),
                obscureText: !showPassword,
                controller: _passwordController,
                keyboardType:
                    showPassword ? TextInputType.visiblePassword : null,
                enableSuggestions: false,
                autocorrect: false,
              );
            }),
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
          onPressed: () {
            context.read<SourcesService>().addRemote(
                RemoteStorage.iCal(
                    url: _urlController.text,
                    username: _usernameController.text),
                _passwordController.text);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
