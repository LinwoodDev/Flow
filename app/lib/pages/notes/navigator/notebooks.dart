part of 'drawer.dart';

class _NotebooksView extends StatefulWidget {
  final SourcedModel<Notebook?>? model;

  const _NotebooksView({
    this.model,
  });

  @override
  State<_NotebooksView> createState() => _NotebooksViewState();
}

class _NotebooksViewState extends State<_NotebooksView> {
  late final SourcedPagingController<Notebook> _controller;

  @override
  void initState() {
    super.initState();

    _controller = SourcedPagingController(
      context.read<FlowCubit>(),
    );
    _controller.addFetchListener((source, service, offset, limit) async {
      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: _controller,
      builderDelegate: buildMaterialPagedDelegate<SourcedModel<Notebook>>(
        _controller,
        (ctx, item, index) => ListTile(
          title: Text(item.model.name),
        ),
      ),
    );
  }
}
