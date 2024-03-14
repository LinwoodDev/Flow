import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

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
        labelColor: colorScheme.tertiary,
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
    required this.labelColor,
  });

  final DateTime dateTime;
  final Color hourHandColor,
      minuteHandColor,
      secondHandColor,
      indicatorColor,
      backgroundColor,
      labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    final indicatorPaint = Paint()
      ..color = indicatorColor
      ..strokeWidth = 2;
    var textStyle = TextStyle(
      color: indicatorColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    for (var i = 0; i < 12; i++) {
      final angle = (i - 2) * 2 * pi / 12;
      final line = Offset.fromDirection(angle, radius);
      canvas.drawLine(
          center + line * 0.8, center + line * 0.95, indicatorPaint);
      final textSpan = TextSpan(
        text: '${i + 1}',
        style: textStyle,
      );
      textPainter.text = textSpan;
      textPainter.layout();
      final textOffset =
          center + line * 0.7 - textPainter.size.center(Offset.zero);
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
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;
    drawHand(hourAngle, hourHandPaint, 0.5);

    final minuteAngle = dateTime.minute * 2 * pi / 60;
    final minuteHandPaint = Paint()
      ..color = minuteHandColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    drawHand(minuteAngle, minuteHandPaint, 0.7);

    final secondAngle = dateTime.second * 2 * pi / 60;
    final secondHandPaint = Paint()
      ..color = secondHandColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    drawHand(secondAngle, secondHandPaint, 0.9);

    canvas.drawCircle(center, 5, indicatorPaint);
    textStyle = textStyle.copyWith(
        fontSize: 20, fontWeight: FontWeight.bold, color: labelColor);
    textPainter.text = TextSpan(
      text: intl.DateFormat.Hms().format(dateTime),
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
