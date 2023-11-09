import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteListTile extends StatelessWidget {
  final String source;
  final Note note;

  const NoteListTile({
    super.key,
    required this.source,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.name),
      subtitle: MarkdownText(note.description),
      onTap: () {
        GoRouter.of(context).pushNamed(
          source.isEmpty ? "subnote-local" : "subnote",
          pathParameters: {
            if (source.isNotEmpty) "source": source,
            "id": note.id!.toBase64Url(),
          },
        );
      },
    );
  }
}
