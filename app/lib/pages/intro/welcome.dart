import 'package:flutter/material.dart';

class IntroWelcomeView extends StatelessWidget {
  const IntroWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Icon(Icons.wb_sunny_outlined, size: 128),
      SizedBox(height: 16),
      Text(
        "Welcome to Flow",
        style: TextStyle(fontSize: 32),
      ),
      SizedBox(height: 16),
      Text(
        "Flow is a simple, open-source, self-hosted, and privacy-focused task management app.",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 16),
      Text(
        "To get started, please create an account or sign in.",
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
