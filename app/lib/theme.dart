import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'main.dart';

const kClassicThemePrimary = isNightly ? Color(0xFF6877FD) : Color(0xFFA28DDB);
const kClassicThemeSecondary = Color(0xFF35EF53);
const kClassicTheme = FlexSchemeColor(
    primary: kClassicThemePrimary, secondary: kClassicThemeSecondary);
const kClassicThemeData = FlexSchemeData(
    name: '', description: '', light: kClassicTheme, dark: kClassicTheme);

ThemeData getThemeData(String name, bool dark, [ColorScheme? overridden]) {
  final color = getFlexThemeColor(name, dark);
  final override = overridden != null && name.isEmpty;
  if (dark) {
    return FlexThemeData.dark(
      colors: override ? null : color,
      colorScheme: override ? overridden : null,
      useMaterial3: true,
      appBarElevation: 2,
      fontFamily: 'Comfortaa',
      swapLegacyOnMaterial3: true,
      fontFamilyFallback: ['Comfortaa'],
    );
  }
  return FlexThemeData.light(
    colors: override ? null : color,
    colorScheme: override ? overridden : null,
    useMaterial3: true,
    appBarElevation: 0.5,
    fontFamily: 'Comfortaa',
    swapLegacyOnMaterial3: true,
    fontFamilyFallback: ['Comfortaa'],
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
