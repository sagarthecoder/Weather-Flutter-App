import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

enum ThemeEnum { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeEnum currentTheme = ThemeEnum.light;
  ThemeData? currentThemeData;

  ThemeProvider._internal();
  static final instance = ThemeProvider._internal();

  Future<void> changeTheme(ThemeEnum theme) async {
    currentTheme = theme;
    await _generateThemeData();
    notifyListeners();
  }

  Future<void> _generateThemeData() async {
    String themeStr = await rootBundle.loadString(_getJsonPath());
    Map themeJson = jsonDecode(themeStr);
    currentThemeData = ThemeDecoder.decodeThemeData(themeJson);
  }

  String _getJsonPath() {
    switch (currentTheme) {
      case ThemeEnum.light:
        return 'utils/themes/theme_light.json';
      case ThemeEnum.dark:
        return 'utils/themes/theme_dark.json';
    }
  }
}
