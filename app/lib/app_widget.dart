import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromRGBO(124, 77, 255, 1);
    return ValueListenableBuilder(
        valueListenable: Hive.box('appearance').listenable(),
        builder: (context, dynamic box, widget) {
          return MaterialApp.router(
            /*builder: (context, child) => child == null ? Container() : MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child),*/
            title: 'Linwood Flow',
            themeMode: ThemeMode.values[box.get('theme', defaultValue: 0)],
            theme: ThemeData(
                useMaterial3: true,
                fontFamily: "Comfortaa",
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: createMaterialColor(color),
                indicatorColor: color,
                colorScheme: ColorScheme.light(
                    primary: color, secondary: const Color(0xFF64dd17)),
                visualDensity: VisualDensity.adaptivePlatformDensity),
            darkTheme: ThemeData(
                useMaterial3: true,
                fontFamily: "Comfortaa",
                brightness: Brightness.dark,
                primarySwatch: createMaterialColor(color),
                indicatorColor: color,
                colorScheme: ColorScheme.dark(
                    primary: color,
                    onPrimary: Colors.white,
                    secondary: const Color(0xFF64dd17)),
                visualDensity: VisualDensity.adaptivePlatformDensity),
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          );
        });
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
