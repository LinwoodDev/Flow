import 'package:flutter/material.dart';

/// A responsive scaffold for our application.
/// Displays the navigation drawer alongside the [Scaffold] if the screen/window size is large enough
class ResponsiveScaffold extends StatelessWidget {
  const ResponsiveScaffold(
      {required this.body,
      this.pageTitle = '',
      Key? key,
      this.floatingActionButton,
      this.bottom,
      required this.drawer,
      required this.desktopDrawer,
      this.actions = const []})
      : super(key: key);
  final List<Widget> actions;

  final Widget drawer;
  final Widget desktopDrawer;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  final PreferredSizeWidget? bottom;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 768;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
              child: Scaffold(
                  appBar: AppBar(
                    // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
                    automaticallyImplyLeading: displayMobileLayout,
                    title: Text(pageTitle),
                    actions: actions,
                    bottom: bottom,
                  ),
                  drawer: displayMobileLayout ? Drawer(child: drawer) : null,
                  body: body,
                  floatingActionButton: floatingActionButton)),
          if (!displayMobileLayout) Drawer(child: desktopDrawer)
        ]);
  }
}
