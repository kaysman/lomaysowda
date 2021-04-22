import 'package:flutter/material.dart';
import 'package:lomaysowda/config/custom_theme.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.yellow),
      dividerColor: Colors.white54,
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      accentColor: Colors.black,
      accentIconTheme: IconThemeData(color: Colors.yellow),
      dividerColor: Colors.white54,
      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
