part of 'navigator/drawer.dart';

class NotesListView extends StatelessWidget {
  final SourcedPagingController<Note> controller;

  const NotesListView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: controller,
      builderDelegate: buildMaterialPagedDelegate<SourcedModel<Note>>(
        controller,
        (ctx, item, index) => NoteListTile(
          note: item.model,
          source: item.source,
        ),
      ),
    );
  }
}
