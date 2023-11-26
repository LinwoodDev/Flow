import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({super.key});

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late final Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: _ClockPainter(
        dateTime: _dateTime,
        hourHandColor: colorScheme.primary,
        minuteHandColor: colorScheme.primary,
        secondHandColor: colorScheme.secondary,
        indicatorColor: colorScheme.onSurface,
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  _ClockPainter({
    required this.dateTime,
    required this.hourHandColor,
    required this.minuteHandColor,
    required this.secondHandColor,
    required this.indicatorColor,
    required this.backgroundColor,
  });

  final DateTime dateTime;
  final Color hourHandColor,
      minuteHandColor,
      secondHandColor,
      indicatorColor,
      backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(backgroundColor, BlendMode.color);

    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;

    final indicatorPaint = Paint()..color = indicatorColor;
    canvas.drawCircle(center, 10, indicatorPaint);
    var textStyle = TextStyle(
      color: indicatorColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    for (var i = 0; i < 12; i++) {
      final angle = (i - 2) * 2 * pi / 12;
      final line = Offset.fromDirection(angle, radius);
      canvas.drawLine(center + line * 0.9, center + line, indicatorPaint);
      final textSpan = TextSpan(
        text: '${i + 1}',
        style: textStyle,
      );
      textPainter.text = textSpan;
      textPainter.layout();
      final textOffset =
          center + line * 0.8 - textPainter.size.center(Offset.zero);
      textPainter.paint(canvas, textOffset);
    }

    void drawHand(double angle, Paint paint, [double length = 1]) {
      angle -= pi / 2;
      final line = Offset.fromDirection(angle, radius * length);
      canvas.drawLine(center, center + line, paint);
    }

    final hourAngle =
        dateTime.hour * 2 * pi / 12 + dateTime.minute * 2 * pi / (12 * 60);
    final hourHandPaint = Paint()
      ..color = hourHandColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    drawHand(hourAngle, hourHandPaint, 0.5);

    final minuteAngle = dateTime.minute * 2 * pi / 60;
    final minuteHandPaint = Paint()
      ..color = minuteHandColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    drawHand(minuteAngle, minuteHandPaint, 0.7);

    final secondAngle = dateTime.second * 2 * pi / 60;
    final secondHandPaint = Paint()
      ..color = secondHandColor
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    drawHand(secondAngle, secondHandPaint, 0.9);

    textStyle = textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold);
    textPainter.text = TextSpan(
      text: '${dateTime.hour}:${dateTime.minute}:${dateTime.second}',
      style: textStyle,
    );
    textPainter.layout();
    final textOffset =
        center - textPainter.size.center(Offset.zero) + Offset(0, radius * 0.4);
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(_ClockPainter oldDelegate) =>
      oldDelegate.dateTime != dateTime ||
      oldDelegate.hourHandColor != hourHandColor ||
      oldDelegate.minuteHandColor != minuteHandColor ||
      oldDelegate.secondHandColor != secondHandColor ||
      oldDelegate.indicatorColor != indicatorColor ||
      oldDelegate.backgroundColor != backgroundColor;
}
