import 'package:flow_app/intro/welcome.dart';
import 'package:flow_app/session/connect.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const _pages = [IntroWelcomePage(), ConnectPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView(children: _pages, controller: _pageController),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(child: Container()),
            OutlinedButton(
                onPressed: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear),
                child: const Text("NEXT"))
          ]),
        )
      ],
    ));
  }
}
