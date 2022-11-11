part of 'page.dart';

class _TodoCard extends StatefulWidget {
  final String source;
  final Event? event;
  final EventTodo todo;

  const _TodoCard({
    required this.source,
    required this.event,
    required this.todo,
  });

  @override
  State<_TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<_TodoCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late EventTodo _newTodo;
  late final EventTodoService _todoService;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.todo.name);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    _newTodo = widget.todo;
    _todoService = context
        .read<FlowCubit>()
        .getCurrentServicesMap()[widget.source]!
        .eventTodo;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _newTodo = _newTodo.copyWith(name: _nameController.text);
        _updateTodo();
      }
    });
    _descriptionFocus.addListener(() {
      if (!_descriptionFocus.hasFocus) {
        _newTodo = _newTodo.copyWith(description: _descriptionController.text);
        _updateTodo();
      }
    });
  }

  Future<void> _updateTodo() async {
    setState(() => _loading = true);
    await _todoService.updateTodo(
      _newTodo,
    );
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    final timeFormatter = DateFormat.Hm(locale);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: _newTodo.done,
                    onChanged: (value) {
                      setState(() {
                        _newTodo = _newTodo.copyWith(done: value!);
                        _updateTodo();
                      });
                    },
                  );
                }),
                const SizedBox(width: 8),
                Flexible(
                    child: TextFormField(
                  controller: _nameController,
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: AppLocalizations.of(context)!.name,
                  ),
                  focusNode: _nameFocus,
                  onEditingComplete: () {
                    _newTodo = _newTodo.copyWith(name: _nameController.text);
                    _updateTodo();
                  },
                  onFieldSubmitted: (value) {
                    _newTodo = _newTodo.copyWith(name: value);
                    _updateTodo();
                  },
                )),
              ],
            ),
            if (widget.source.isNotEmpty)
              Text(widget.source, style: Theme.of(context).textTheme.caption),
            if (widget.event != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 32,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(widget.event!.status.getIcon(),
                          color: widget.event!.status.getColor()),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                            AppLocalizations.of(context)!.eventInfo(
                              widget.event!.name,
                              widget.event?.start == null
                                  ? '-'
                                  : dateFormatter.format(widget.event!.start!),
                              widget.event?.start == null
                                  ? '-'
                                  : timeFormatter.format(widget.event!.start!),
                              widget.event!.location.isEmpty
                                  ? '-'
                                  : widget.event!.location,
                              widget.event!.status.getLocalizedName(context),
                            ),
                            style: Theme.of(context).textTheme.caption),
                      ),
                      if (_loading) ...[
                        const SizedBox(width: 8),
                        const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              focusNode: _descriptionFocus,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                border: const OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              onEditingComplete: () {
                _newTodo =
                    _newTodo.copyWith(description: _descriptionController.text);
                _updateTodo();
              },
              onSaved: (value) {
                if (value == null) return;
                _newTodo = _newTodo.copyWith(description: value);
                _updateTodo();
              },
              onFieldSubmitted: (value) {
                _newTodo = _newTodo.copyWith(description: value);
                _updateTodo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
