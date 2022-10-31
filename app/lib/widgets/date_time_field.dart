import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatefulWidget {
  final DateTime? initialValue;
  final String label;
  final Widget? icon;
  final ValueChanged<DateTime> onChanged;

  const DateTimeField({
    super.key,
    this.initialValue,
    required this.label,
    required this.onChanged,
    this.icon,
  });

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  late DateTime _value;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? DateTime.now();
  }

  void _change(DateTime value) {
    setState(() {
      _value = value;
    });
  }

  String _format(DateTime value) {
    String locale = Localizations.localeOf(context).languageCode;
    return '${DateFormat.yMMMd(locale).format(value)} ${DateFormat.Hm().format(value)}';
  }

  DateTime _addYears(DateTime dateTime, int years) {
    return DateTime(dateTime.year + years, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = _format(_value);
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        labelText: widget.label,
        icon: widget.icon ?? const Icon(Icons.date_range_outlined),
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () async {
                  final result = await showDatePicker(
                    context: context,
                    initialDate: _value,
                    firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
                    lastDate: _addYears(_value, 200),
                  );
                  if (result != null) {
                    _change(result);
                  }
                }),
            IconButton(
                icon: const Icon(Icons.access_time_outlined),
                onPressed: () async {
                  final result = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_value),
                  );
                  if (result != null) {
                    _change(DateTime(
                        _value.year,
                        _value.month,
                        _value.day,
                        result.hour,
                        result.minute,
                        _value.second,
                        _value.millisecond));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
