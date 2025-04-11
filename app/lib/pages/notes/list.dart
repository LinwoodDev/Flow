part of 'navigator/drawer.dart';

class NotesListView extends StatelessWidget {
  final SourcedPagingBloc<Note> bloc;

  const NotesListView({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView.item(
      bloc: bloc,
      itemBuilder: (ctx, item, index) => NoteListTile(
        note: item.model,
        source: item.source,
        bloc: bloc,
      ),
    );
  }
}
