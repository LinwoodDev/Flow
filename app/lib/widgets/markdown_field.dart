import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownField extends StatefulWidget {
  final String value;
  final InputDecoration decoration;
  final ValueChanged<String>? onChanged, onChangeEnd;
  final List<Widget> actions;

  const MarkdownField(
      {super.key,
      required this.value,
      this.onChanged,
      this.onChangeEnd,
      this.decoration = const InputDecoration(),
      this.actions = const []});

  @override
  State<MarkdownField> createState() => _MarkdownFieldState();
}

class _MarkdownFieldState extends State<MarkdownField> {
  final TextEditingController _controller = TextEditingController();
  bool _editMode = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _exitEditMode();
      }
    });
  }

  @override
  void didUpdateWidget(MarkdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  void _exitEditMode() {
    setState(() => _editMode = false);
    widget.onChangeEnd?.call(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: SizedBox(
          child: _editMode
              ? TextFormField(
                  decoration: widget.decoration,
                  maxLines: null,
                  minLines: 3,
                  onChanged: widget.onChanged,
                  controller: _controller,
                  onFieldSubmitted: (_) => _exitEditMode(),
                  onEditingComplete: _exitEditMode,
                  onTapOutside: (_) => _exitEditMode,
                  focusNode: _focusNode,
                )
              : GestureDetector(
                  onDoubleTap: () {
                    setState(() => _editMode = true);
                    _focusNode.requestFocus();
                  },
                  child: InputDecorator(
                    decoration: widget.decoration,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) => MarkdownBody(
                        data: _controller.text,
                        onTapText: () => setState(() => _editMode = true),
                        extensionSet: md.ExtensionSet(
                          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                          [
                            md.EmojiSyntax(),
                            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                          ],
                        ),
                        onTapLink: (text, href, title) async {
                          if (href != null && await canLaunchUrlString(href)) {
                            launchUrlString(href);
                          }
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.actions,
        ],
      )
    ]);
  }
}