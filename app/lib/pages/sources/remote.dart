import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/helpers/validation.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef RemoteStorageBuilder = RemoteStorage Function({
  required String name,
  required String url,
  required String username,
});

class RemoteSourceDialog extends StatefulWidget {
  final String title;
  final RemoteStorageBuilder storageBuilder;

  const RemoteSourceDialog({
    super.key,
    required this.title,
    required this.storageBuilder,
  });

  @override
  State<RemoteSourceDialog> createState() => _RemoteSourceDialogState();
}

class _RemoteSourceDialogState extends State<RemoteSourceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _connecting = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _extractCredentials(String value) {
    final credentials = parseRemoteCredentials(value);
    if (credentials == null) return;
    _usernameController.text = credentials.username;
    _passwordController.text = credentials.password;
    _urlController.text = credentials.url.toString();
  }

  Future<void> _connect() async {
    _extractCredentials(_urlController.text);
    if (_connecting || !(_formKey.currentState?.validate() ?? false)) return;

    final uri = parseRemoteUri(_urlController.text)!;
    final storage = widget.storageBuilder(
      name: _nameController.text.trim(),
      url: uri.toString(),
      username: _usernameController.text.trim(),
    );
    final sources = context.read<SourcesService>();
    if (sources.getRemotes().any(
      (current) => current.identifier == storage.identifier,
    )) {
      setState(() {
        _error = AppLocalizations.of(context).sourceAlreadyExists;
      });
      return;
    }

    setState(() {
      _connecting = true;
      _error = null;
    });
    try {
      await sources.addRemote(storage, _passwordController.text);
      if (mounted) {
        setState(() => _connecting = false);
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context)
              .connectionFailed(error.toString());
        });
      }
    } finally {
      if (mounted && _connecting) setState(() => _connecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                enabled: !_connecting,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).name,
                  hintText: AppLocalizations.of(context).sourceNameHint,
                  icon: const PhosphorIcon(PhosphorIconsLight.textT),
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).url,
                  icon: const PhosphorIcon(PhosphorIconsLight.globe),
                  border: const OutlineInputBorder(),
                ),
                controller: _urlController,
                onChanged: _extractCredentials,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                enabled: !_connecting,
                validator: (value) => parseRemoteUri(value ?? '') == null
                    ? AppLocalizations.of(context).invalidUrl
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).username,
                  icon: const PhosphorIcon(PhosphorIconsLight.user),
                  filled: true,
                ),
                controller: _usernameController,
                textInputAction: TextInputAction.next,
                enabled: !_connecting,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).password,
                  icon: const PhosphorIcon(PhosphorIconsLight.lock),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: PhosphorIcon(
                      _showPassword
                          ? PhosphorIconsLight.lockOpen
                          : PhosphorIconsLight.lock,
                    ),
                    tooltip: _showPassword
                        ? AppLocalizations.of(context).hidePassword
                        : AppLocalizations.of(context).showPassword,
                    onPressed: _connecting
                        ? null
                        : () => setState(() => _showPassword = !_showPassword),
                  ),
                ),
                obscureText: !_showPassword,
                controller: _passwordController,
                keyboardType: _showPassword
                    ? TextInputType.visiblePassword
                    : null,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _connect(),
                enabled: !_connecting,
                enableSuggestions: false,
                autocorrect: false,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: _connecting ? null : () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: _connecting ? null : _connect,
          child: _connecting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(AppLocalizations.of(context).connect),
        ),
      ],
    );
  }
}
