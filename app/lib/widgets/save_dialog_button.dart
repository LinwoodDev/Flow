import 'package:flutter/material.dart';

class SaveDialogButton<T> extends StatefulWidget {
  final Future<T?> Function() onSave;
  final Widget child;
  final String errorMessage;

  const SaveDialogButton({
    super.key,
    required this.onSave,
    required this.child,
    required this.errorMessage,
  });

  @override
  State<SaveDialogButton<T>> createState() => _SaveDialogButtonState<T>();
}

class _SaveDialogButtonState<T> extends State<SaveDialogButton<T>> {
  bool _saving = false;

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    try {
      final result = await widget.onSave();
      if (!mounted) return;
      if (result == null) {
        _showError();
        return;
      }
      Navigator.of(context).pop<T>(result);
    } catch (_) {
      if (mounted) _showError();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(widget.errorMessage)));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _saving ? null : _save,
      child: _saving
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : widget.child,
    );
  }
}
