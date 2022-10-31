import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatelessWidget {
  final DateTime? value;

  const DateTimeField({super.key, this.value});

  String _format(BuildContext context, DateTime value) {
    String locale = Localizations.localeOf(context).languageCode;
    return '${DateFormat.yMMMd(locale).format(value)} ${DateFormat.Hm().format(value)}';
  }

  DateTime _addYears(DateTime dateTime, int years) {
    return DateTime(dateTime.year + years, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second, dateTime.millisecond);
  }

  @override
  Widget build(BuildContext context) {
    final currentValue = value ?? DateTime.now();
    return TextFormField(
      initialValue: _format(context, currentValue),
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        labelText: 'Date',
        icon: const Icon(Icons.date_range_outlined),
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: currentValue,
                    firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
                    lastDate: _addYears(currentValue, 500),
                  );
                }),
            IconButton(
                icon: const Icon(Icons.access_time_outlined),
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
