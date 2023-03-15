import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalDavSourceDialog extends StatelessWidget {
  final TextEditingController _urlController = TextEditingController(),
      _usernameController = TextEditingController(),
      _passwordController = TextEditingController();
  CalDavSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).caldav),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).url,
                icon: const Icon(Icons.web_outlined),
                border: const OutlineInputBorder(),
              ),
              controller: _urlController,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).username,
                icon: const Icon(Icons.person_outline),
                filled: true,
              ),
              controller: _usernameController,
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).password,
                icon: const Icon(Icons.lock_outline),
                filled: true,
              ),
              obscureText: true,
              controller: _passwordController,
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
          onPressed: () {
            context.read<SourcesService>().addRemote(
                RemoteStorage.calDav(
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
