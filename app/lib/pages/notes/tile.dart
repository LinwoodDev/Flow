import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteListTile extends StatelessWidget {
  final String source;
  final Note note;
  final SourcedPagingController<Note>? controller;

  const NoteListTile({
    super.key,
    required this.source,
    required this.note,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: note.status == null
          ? null
          : Checkbox(
              tristate: true,
              value: note.status?.done,
              onChanged: null,
            ),
      title: Text(note.name),
      subtitle: MarkdownText(note.description),
      onTap: () async {
        await GoRouter.of(context).pushNamed(
          source.isEmpty ? "subnote-local" : "subnote",
          pathParameters: {
            if (source.isNotEmpty) "source": source,
            "id": note.id!.toBase64Url(),
          },
        );
        controller?.refresh();
      },
    );
  }
}
