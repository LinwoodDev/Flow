import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

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
      orElse: () => FlexColor.mandyRed);
  if (dark) return color.dark;
  return color.light;
}

List<String> getThemes() {
  return FlexColor.schemesList.map((e) => e.name).toList();
}
