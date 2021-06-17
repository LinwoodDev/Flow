import 'package:flutter/material.dart';

typedef void ColorCallback(Color color);

class ColorPicker extends StatefulWidget {
  final ColorCallback onClick;
  final Color? initialColor;

  const ColorPicker({Key? key, required this.onClick, this.initialColor}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color color = Colors.white;
  late TextEditingController _redController;
  late TextEditingController _greenController;
  late TextEditingController _blueController;

  final ScrollController _scrollController = ScrollController();
  static const colors = const [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];

  @override
  void initState() {
    super.initState();

    color = widget.initialColor ?? Colors.white;
    _redController = TextEditingController(text: color.red.toString());
    _greenController = TextEditingController(text: color.green.toString());
    _blueController = TextEditingController(text: color.blue.toString());
  }

  void changeColor({int? red, int? green, int? blue}) {
    setState(() {
      color = Color.fromRGBO(red ?? color.red, green ?? color.green, blue ?? color.blue, 1);
      _redController.text = color.red.toString();
      _greenController.text = color.green.toString();
      _blueController.text = color.blue.toString();
    });
    widget.onClick(color);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        constraints: BoxConstraints(maxWidth: 1000),
        height: 350,
        child: Row(children: [
          Expanded(
              child: Column(children: [
            Expanded(child: Container(color: color)),
            Expanded(
                child: Column(children: [
              Row(
                children: [
                  SizedBox(
                      width: 50,
                      child: TextField(
                          textAlign: TextAlign.center,
                          controller: _redController,
                          onSubmitted: (value) => changeColor(red: int.tryParse(value)))),
                  Expanded(
                    child: SliderTheme(
                        data: SliderThemeData(thumbColor: Colors.red),
                        child: Slider(
                            value: color.red.toDouble(),
                            min: 0,
                            max: 255,
                            divisions: 255,
                            label: color.red.round().toString(),
                            onChanged: (double value) => changeColor(red: value.toInt()))),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 50,
                      child: TextField(
                          textAlign: TextAlign.center,
                          controller: _greenController,
                          onSubmitted: (value) => changeColor(green: int.tryParse(value)))),
                  Expanded(
                    child: SliderTheme(
                        data: SliderThemeData(thumbColor: Colors.green),
                        child: Slider(
                            value: color.green.toDouble(),
                            min: 0,
                            max: 255,
                            divisions: 255,
                            label: color.green.round().toString(),
                            onChanged: (double value) => changeColor(green: value.toInt()))),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 50,
                      child: TextField(
                          textAlign: TextAlign.center,
                          controller: _blueController,
                          onSubmitted: (value) => changeColor(blue: int.tryParse(value)))),
                  Expanded(
                    child: SliderTheme(
                        data: SliderThemeData(thumbColor: Colors.blue),
                        child: Slider(
                            value: color.blue.toDouble(),
                            min: 0,
                            max: 255,
                            divisions: 255,
                            label: color.blue.round().toString(),
                            onChanged: (double value) => changeColor(blue: value.toInt()))),
                  ),
                ],
              )
            ]))
          ])),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(colors.length, (index) {
                        var color = colors[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              child: Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                                  height: 50,
                                  width: 50),
                              onTap: () => changeColor(
                                  red: color.red, green: color.green, blue: color.blue)),
                        );
                      })),
                ),
              ),
            ),
          ))
        ]));
  }
}
