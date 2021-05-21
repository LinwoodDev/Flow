import 'package:flutter/material.dart';

typedef void TimeChangedCallback(TimeOfDay? timeTime);

class TimeInputField extends StatefulWidget {
  final TimeOfDay initialTime;
  final TimeChangedCallback? onChanged;

  TimeInputField({Key? key, TimeOfDay? initialTime, this.onChanged})
      : this.initialTime = initialTime ?? TimeOfDay.now(),
        super(key: key);

  @override
  _TimeInputFieldState createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {
  late TextEditingController _textController;
  final textFieldFocusNode = FocusNode();
  TimeOfDay? currentTime;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialTime.toString());
    currentTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textController,
        focusNode: textFieldFocusNode,
        decoration: InputDecoration(
            labelText: "Time",
            suffixIcon: currentTime == null
                ? null
                : IconButton(icon: Icon(Icons.close), onPressed: () => changeTime(null))),
        readOnly: true,
        onTap: () => textFieldFocusNode.canRequestFocus
            ? showTimePicker(context: context, initialTime: currentTime ?? TimeOfDay.now())
                .then(changeTime)
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
  }
}
