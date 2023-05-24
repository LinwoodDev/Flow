import 'package:flutter/material.dart';

class ColorPoint extends StatelessWidget {
  final Color color;
  final VoidCallback? onTap;

  const ColorPoint({super.key, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: color,
          ),
        ));
  }
}
