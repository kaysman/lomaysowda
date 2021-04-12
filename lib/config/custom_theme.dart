import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/main/provider/theme_provider.dart';

CustomTheme currentTheme = CustomTheme();

class CustomColors {
  static const Color grey = Color(0xFF848484);
  static const Color darkGrey = Color(0xFF222222);
  static const Color black = Color(0xFF141414);
  static const Color unselectedItemColor = Color(0xff999999);
  static const Color selectedItemColor = Color(0xFF703737);
  static const Color backgroundColor = Color(0xfffefefe);
  static const Color dividerColor = Color(0xffdfdfdf);
  static const Color appBarColor = Color(0xFFA70B0B);
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.red),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFD0E9FA),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.yellow),
  dividerColor: Colors.white54,
);

// status bar style

// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     systemNavigationBarColor: Colors.blue, // navigation bar color
//     statusBarColor: Colors.pink, // status bar color
//     statusBarBrightness: Brightness.dark,//status bar brigtness
//     statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
//     systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
//     systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
//   ));
