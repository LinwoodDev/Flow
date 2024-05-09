part of 'drawer.dart';

typedef LabelChangedCallback = void Function(SourcedModel<Label>, bool);

class _NoteLabelsView extends StatefulWidget {
  final Multihash? selected;
  final LabelChangedCallback? onChanged;

  const _NoteLabelsView({this.selected, this.onChanged});

  @override
  State<_NoteLabelsView> createState() => _NoteLabelsViewState();
}

class _NoteLabelsViewState extends State<_NoteLabelsView> {
  late final SourcedPagingController<Label> _pagingController;
  late final FlowCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _pagingController = SourcedPagingController(_cubit);
    _pagingController.addFetchListener((source, service, offset, limit) =>
        Future.value(service.label?.getLabels(offset: offset, limit: limit)));
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  void didUpdateWidget(covariant _NoteLabelsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {});
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).labels,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.plus),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const LabelDialog(),
                  ).then((value) => _pagingController.refresh()),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: PagedListView(
                scrollDirection: Axis.horizontal,
                pagingController: _pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Label>>(
                  _pagingController,
                  (context, item, index) {
                    final selected = widget.selected == item.model.id;
                    return MenuAnchor(
                      builder: (context, controller, child) => Tooltip(
                        message: item.model.name,
                        child: ColorButton(
                          onTap: () => widget.onChanged?.call(item, !selected),
                          selected: selected,
                          color: Color(item.model.color).withAlpha(255),
                          onLongPress: controller.toggle,
                          onSecondaryTap: controller.toggle,
                        ),
                      ),
                      menuChildren: [
                        MenuItemButton(
                            leadingIcon:
                                const PhosphorIcon(PhosphorIconsLight.pencil),
                            child: Text(AppLocalizations.of(context).edit),
                            onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => LabelDialog(
                                          source: item.source,
                                          label: item.model,
                                        ))
                                .then((value) => _pagingController.refresh())),
                        MenuItemButton(
                          leadingIcon:
                              const PhosphorIcon(PhosphorIconsLight.trash),
                          child: Text(AppLocalizations.of(context).delete),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)
                                  .deleteLabel(item.model.name)),
                              content: Text(AppLocalizations.of(context)
                                  .deleteLabelDescription(item.model.name)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final id = item.model.id;
                                    if (id == null) return;
                                    await _cubit
                                        .getService(item.source)
                                        .label
                                        ?.deleteLabel(id);
                                    _pagingController.refresh();
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
