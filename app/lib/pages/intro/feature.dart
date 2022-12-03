import 'package:flutter/material.dart';

class IntroFeatureView extends StatelessWidget {
  final String title, description;
  final Widget icon;

  const IntroFeatureView({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth / 2,
          ),
          child: icon,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 32),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          "To get started, please create an account or sign in.",
          textAlign: TextAlign.center,
        ),
      ]);
    });
  }
}
