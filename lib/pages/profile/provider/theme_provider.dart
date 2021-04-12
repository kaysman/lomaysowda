import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themData;
  ThemeNotifier(this._themData);

  ThemeData get getTheme => this._themData;

  setTheme(ThemeData themeData) async {
    this._themData = themeData;
    await Future.delayed(Duration(milliseconds: 200));
    notifyListeners();
  }
}
