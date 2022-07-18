import 'package:flow/session/connect.dart';
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

  static final _pages = <Widget>[
    ...[
      {
        "image": "images/undraw_welcome_3gvl.png",
        "title": "Welcome to Linwood Flow",
        "description": "A feature rich event and time managment system"
      },
      {
        "image": "images/undraw_time_management_30iu.png",
        "title": "Time management",
        "description": "Manage the time efficiency and automate it."
      },
      {
        "image": "images/undraw_Schedule_re_2vro.png",
        "title": "Event management",
        "description":
            "Schedule events, assign users to it and give tasks to them"
      },
      {
        "image": "images/undraw_personal_data_29co.png",
        "title": "Your data",
        "description":
            "Everyone can create their own server and have your data on it."
      },
      {
        "image": "images/undraw_open_source_1qxw.png",
        "title": "Open source",
        "description":
            "The app and the server are all open source. Everyone can contribute!"
      }
    ].map((e) => Builder(
          builder: (context) => ListView(children: [
            Image(height: 500, image: AssetImage(e["image"] ?? "")),
            const SizedBox(height: 50),
            Text(e["title"] ?? "",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Text(e["description"] ?? "", textAlign: TextAlign.center),
            const SizedBox(height: 50)
          ]),
        )),
    const ConnectPage(inIntro: true)
  ];

  void _setPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: Align(
          child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (value) => setState(() => _currentPage = value),
              children: _pages),
        ),
      ),
      const Divider(),
      Row(children: [
        Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (_currentPage != 0)
                      ElevatedButton(
                        onPressed: () {
                          _setPage(_currentPage - 1);
                        },
                        child: const Text("PREVIOUS"),
                      )
                  ]),
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          height: 40,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _pages.length,
                  (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: _currentPage.round() == index
                              ? const Color(0XFF256075)
                              : const Color(0XFF256075).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: InkWell(onTap: () => _setPage(index))))),
        ),
        Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (_currentPage != _pages.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          _setPage(_currentPage + 1);
                        },
                        child: const Text("NEXT"),
                      )
                  ]),
            ))
      ]),
    ]));
  }
}
