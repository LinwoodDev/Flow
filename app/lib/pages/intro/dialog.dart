import 'package:flow/pages/intro/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroDialog extends StatefulWidget {
  const IntroDialog({super.key});

  @override
  State<IntroDialog> createState() => _IntroDialogState();
}

class _IntroDialogState extends State<IntroDialog> {
  final _pages = const [
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
    IntroWelcomeView(),
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
                return Row(
                  children: [
                    Expanded(
                      child: Builder(builder: (context) {
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
                    ),
                    const SizedBox(width: 8),
                    if (_pageController.page != _pages.length - 1) ...[
                      OutlinedButton(
                          child: Text(AppLocalizations.of(context)!.skip),
                          onPressed: () => _pageController.animateToPage(
                              _pages.length - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut)),
                      const SizedBox(width: 8),
                    ],
                    if ((_pageController.page ?? 0) > 0)
                      TextButton(
                        onPressed: () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                        child: Text(AppLocalizations.of(context)!.back),
                      ),
                    if (_pageController.page != _pages.length - 1) ...[
                      ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.next),
                          onPressed: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut)),
                    ] else
                      ElevatedButton(
                          child: Text(AppLocalizations.of(context)!.start),
                          onPressed: () {}),
                  ],
                );
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
