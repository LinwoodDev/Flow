import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/services/source.dart';

class AppointmentSelectDialog extends StatefulWidget {
  final String? source;
  final MapEntry<String, int>? selected;
  final int? ignore;

  const AppointmentSelectDialog({
    super.key,
    this.source,
    this.selected,
    this.ignore,
  });

  @override
  State<AppointmentSelectDialog> createState() =>
      _AppointmentSelectDialogState();
}

class _AppointmentSelectDialogState extends State<AppointmentSelectDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, MapEntry<String, Appointment>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cubit = context.read<FlowCubit>();
      Map<String, SourceService> sources = widget.source == null
          ? cubit.getCurrentServicesMap()
          : {widget.source!: cubit.getSource(widget.source!)};
      final appointments =
          await Future.wait(sources.entries.map((source) async {
        final appointments = await source.value.appointment?.getAppointments(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: _controller.text,
        );
        return (appointments ?? <Appointment>[])
            .map((event) => MapEntry(source.key, event))
            .where((element) =>
                element.value.id != widget.ignore ||
                source.key != widget.source)
            .toList();
      }));
      final allAppointments =
          appointments.expand((element) => element).toList();
      final isLast = appointments.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(allAppointments);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(allAppointments, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    final timeFormatter = DateFormat.Hm(locale);
    return AlertDialog(
      title: Text(AppLocalizations.of(context).event),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).search,
                icon: const Icon(Icons.search_outlined),
              ),
              controller: _controller,
              onSubmitted: (_) {
                _pagingController.refresh();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView<int, MapEntry<String, Appointment>>(
                pagingController: _pagingController,
                builderDelegate: buildMaterialPagedDelegate(
                  _pagingController,
                  (context, item, index) {
                    final appointment = item.value;
                    return ListTile(
                      subtitle: Text(item.key),
                      selected: widget.selected?.value == item.value.id &&
                          widget.selected?.key == item.key,
                      title: Text(AppLocalizations.of(context).eventInfo(
                        appointment.name,
                        appointment.start == null
                            ? '-'
                            : dateFormatter.format(appointment.start!),
                        appointment.end == null
                            ? '-'
                            : timeFormatter.format(appointment.end!),
                        appointment.location.isEmpty
                            ? '-'
                            : appointment.location,
                        appointment.status.getLocalizedName(context),
                      )),
                      onTap: () {
                        Navigator.of(context)
                            .pop(MapEntry(item.key, item.value.id));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
