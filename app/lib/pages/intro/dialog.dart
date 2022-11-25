import 'package:flow/main.dart';
import 'package:flow/pages/intro/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroDialog extends StatefulWidget {
  const IntroDialog({super.key});

  @override
  State<IntroDialog> createState() => _IntroDialogState();
}

class _IntroDialogState extends State<IntroDialog> {
  final _pages = [
    ...[
      {
        "image": isNightly ? "images/nightly.png" : "images/logo.png",
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
    ].map(
      (e) => IntroFeatureView(
        title: e["title"]!,
        description: e["description"]!,
        icon: Image.asset(e["image"]!),
      ),
    ),
  ];
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 500, minHeight: 300, maxWidth: 500, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: PageView.builder(
                itemCount: _pages.length,
                controller: _pageController,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: _pages[index],
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 16),
              Builder(builder: (context) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Builder(builder: (context) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i = 0; i < _pages.length; i++)
                                _Indicator(
                                  onTap: () => _pageController.animateToPage(i,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut),
                                  active: (_pageController.page ?? 0) == i,
                                ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: (_pageController.page ?? 0) > 0
                                ? () => _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut)
                                : null,
                            child: Text(AppLocalizations.of(context)!.back),
                          ),
                          if (_pageController.page != _pages.length - 1) ...[
                            OutlinedButton(
                                child: Text(AppLocalizations.of(context)!.skip),
                                onPressed: () => _pageController.animateToPage(
                                    _pages.length - 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut)),
                          ],
                          if (_pageController.page != _pages.length - 1) ...[
                            ElevatedButton(
                                child: Text(AppLocalizations.of(context)!.next),
                                onPressed: () => _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut)),
                          ] else
                            ElevatedButton(
                              child: Text(AppLocalizations.of(context)!.start),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                        ],
                      ),
                    ]);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;

  const _Indicator({required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: active ? 32 : 16,
        height: 16,
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: active ? 2 : 10),
        decoration: BoxDecoration(
          color: active ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
