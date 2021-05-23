import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef void DateChangedCallback(DateTime? dateTime);

class DateInputField extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateChangedCallback? onChanged;

  DateInputField(
      {Key? key, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate, this.onChanged})
      : this.initialDate = initialDate ?? DateTime.now(),
        this.firstDate = firstDate ?? DateTime.utc(initialDate?.year ?? DateTime.now().year - 5),
        this.lastDate = firstDate ?? DateTime.utc(initialDate?.year ?? DateTime.now().year + 5),
        super(key: key);

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  late TextEditingController _textController;
  final textFieldFocusNode = FocusNode();
  DateTime? currentDate;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialDate.toString());
    currentDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textController,
        focusNode: textFieldFocusNode,
        decoration: InputDecoration(
            labelText: "Date",
            suffixIcon: currentDate == null
                ? null
                : IconButton(icon: Icon(PhosphorIcons.xLight), onPressed: () => changeDate(null))),
        readOnly: true,
        onTap: () => textFieldFocusNode.canRequestFocus
            ? showDatePicker(
                    context: context,
                    initialDate: currentDate ?? DateTime.now(),
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate)
                .then(changeDate)
            : null);
  }

  void changeDate(DateTime? nextDate) {
    textFieldFocusNode.unfocus();
    textFieldFocusNode.canRequestFocus = false;
    _textController.text =
        nextDate == null ? "" : "${nextDate.year}-${nextDate.month}-${nextDate.day}";
    Future.delayed(Duration(milliseconds: 100), () {
      textFieldFocusNode.canRequestFocus = true;
    });
    setState(() {
      currentDate = nextDate;
    });
  }
}
