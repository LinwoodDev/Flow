part of 'drawer.dart';

class _NoteLabelsView extends StatefulWidget {
  final NoteFilter filter;
  final ValueChanged<NoteFilter>? onChanged;

  const _NoteLabelsView({this.onChanged, required this.filter});

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
    if (oldWidget.filter.selectedLabel != widget.filter.selectedLabel) {
      setState(() {});
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context).labels,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: PagedListView(
                  scrollDirection: Axis.horizontal,
                  pagingController: _pagingController,
                  builderDelegate:
                      buildMaterialPagedDelegate<SourcedModel<Label>>(
                    _pagingController,
                    (context, item, index) {
                      final selected =
                          widget.filter.selectedLabel == item.model.id;
                      return MenuAnchor(
                        builder: (context, controller, child) => Tooltip(
                          message: item.model.name,
                          child: ColorButton(
                            onTap: () =>
                                widget.onChanged?.call(widget.filter.copyWith(
                              selectedLabel: selected ? null : item.model.id,
                              source: item.source,
                            )),
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
                                      )).then(
                                  (value) => _pagingController.refresh())),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                        AppLocalizations.of(context).cancel),
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
                                    child: Text(
                                        AppLocalizations.of(context).delete),
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
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                tooltip: AppLocalizations.of(context).createLabel,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const LabelDialog(),
                ).then((value) => _pagingController.refresh()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
