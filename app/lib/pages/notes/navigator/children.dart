part of 'drawer.dart';

class _NoteChildrenView extends StatefulWidget {
  final SourcedModel<Notebook?>? notebook;
  final Multihash? parent;

  const _NoteChildrenView({
    this.parent,
    this.notebook,
  });

  @override
  State<_NoteChildrenView> createState() => _NoteChildrenViewState();
}

class _NoteChildrenViewState extends State<_NoteChildrenView> {
  late final SourcedPagingController<Note> _controller;

  @override
  void initState() {
    super.initState();

    _controller = SourcedPagingController(
      context.read<FlowCubit>(),
    );
    _controller.addFetchListener((source, service, offset, limit) async {
      final notebook = widget.notebook;
      if (notebook != null && notebook.source != source) return [];
      return service.note?.getNotes(
        offset: offset,
        limit: limit,
        parent: widget.parent,
        notebook: notebook?.source == source ? notebook?.model?.id : null,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant _NoteChildrenView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.parent != widget.parent) {
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: _controller,
      builderDelegate: buildMaterialPagedDelegate<SourcedModel<Note>>(
        _controller,
        (ctx, item, index) => ListTile(
          title: Text(item.model.name),
        ),
      ),
    );
  }
}
