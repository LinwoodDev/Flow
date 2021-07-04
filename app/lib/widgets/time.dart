import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef void TimeChangedCallback(TimeOfDay? timeTime);

class TimeInputField extends StatefulWidget {
  final TimeOfDay? initialTime;
  final String? label;
  final TimeChangedCallback onChanged;

  TimeInputField({Key? key, this.initialTime, required this.onChanged, this.label}) : super(key: key);

  @override
  _TimeInputFieldState createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  final TextEditingController _textController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  TimeOfDay? currentTime;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _textController.text = widget.initialTime?.format(context) ?? "");
    currentTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textController,
        focusNode: textFieldFocusNode,
        decoration: InputDecoration(
            filled: true,
            labelText: widget.label ?? "Time",
            suffixIcon: currentTime == null
                ? null
                : IconButton(icon: Icon(PhosphorIcons.xLight), onPressed: () => changeTime(null))),
        readOnly: true,
        onTap: () => textFieldFocusNode.canRequestFocus
            ? showTimePicker(context: context, initialTime: currentTime ?? TimeOfDay.now()).then(changeTime)
            : null);
  }

  void changeTime(TimeOfDay? nextTime) {
    textFieldFocusNode.unfocus();
    textFieldFocusNode.canRequestFocus = false;
    _textController.text = nextTime == null ? "" : nextTime.format(context);
    Future.delayed(Duration(milliseconds: 100), () {
      textFieldFocusNode.canRequestFocus = true;
    });
    setState(() {
      currentTime = nextTime;
    });
    widget.onChanged(nextTime);
  }
}
