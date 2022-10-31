import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'main.dart';

const kClassicThemePrimary = isNightly ? Color(0xFF6877FD) : Color(0xFFA28DDB);
const kClassicThemeSecondary = Color(0xFF35EF53);
const kClassicTheme = FlexSchemeColor(
    primary: kClassicThemePrimary, secondary: kClassicThemeSecondary);
const kClassicThemeData = FlexSchemeData(
    name: '', description: '', light: kClassicTheme, dark: kClassicTheme);

ThemeData getThemeData(String name, bool dark) {
  final color = getFlexThemeColor(name, dark);
  if (dark) {
    return FlexThemeData.dark(
      colors: color,
      useMaterial3: true,
      appBarElevation: 2,
      fontFamily: 'Comfortaa',
    );
  }
  return FlexThemeData.light(
    colors: color,
    useMaterial3: true,
    appBarElevation: 0.5,
    fontFamily: 'Comfortaa',
  );
}

FlexSchemeColor getFlexThemeColor(String name, bool dark) {
  final color = FlexColor.schemesList.firstWhere(
      (scheme) => scheme.name == name,
      orElse: () => kClassicThemeData);
  if (dark) return color.dark;
  return color.light;
}

List<String> getThemes() {
  return FlexColor.schemesList.map((e) => e.name).toList();
}
