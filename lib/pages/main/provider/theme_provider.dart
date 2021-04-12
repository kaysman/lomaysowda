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
      primaryColor: Colors.yellow,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        buttonColor: Colors.yellowAccent,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColors.darkGrey,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.purple,
      ),
    );
  }
}
