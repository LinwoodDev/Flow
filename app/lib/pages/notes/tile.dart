import 'dart:convert';

import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteListTile extends StatelessWidget {
  final String source;
  final Note note;
  final SourcedPagingBloc<Note>? bloc;

  const NoteListTile({
    super.key,
    required this.source,
    required this.note,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: note.status == null
          ? null
          : Checkbox(
              tristate: true,
              value: note.status?.isDone,
              onChanged: null,
            ),
      title: Text(note.name),
      subtitle: MarkdownText(note.description),
      onTap: () async {
        await GoRouter.of(context).pushNamed(
          source.isEmpty ? "subnote-local" : "subnote",
          pathParameters: {
            if (source.isNotEmpty) "source": source,
            "id": base64Encode(note.id!),
          },
        );
        bloc?.refresh();
      },
    );
  }
}
