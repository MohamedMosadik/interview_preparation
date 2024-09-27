import 'package:flutter/material.dart';
import 'package:interview_preparation/ViewModel/themeLightDark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required this.prefs}) {
    _loadTheme();
  }

  final SharedPreferences prefs;

  ThemeAttrs _attrs = LightThemeAttrs();
  ThemeAttrs get attrs => _attrs;

  Future<void> toggleTheme() async {
    bool isLight = attrs.mode == ThemeModes.light;
    _attrs = isLight ? DarkThemeAttrs() : LightThemeAttrs();
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() {
    int? modeIndex = prefs.getInt("theme");
    ThemeModes mode =
        modeIndex == null ? ThemeModes.light : ThemeModes.values[modeIndex];
    _attrs = mode == ThemeModes.light ? LightThemeAttrs() : DarkThemeAttrs();
  }

  Future<void> _saveTheme() async {
    prefs.setInt("theme", attrs.mode.index);
  }
}
