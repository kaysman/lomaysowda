import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/main/provider/theme_provider.dart';

CustomTheme currentTheme = CustomTheme();

const String _appFontFamily = 'Montserrat';
const Color _textLightColor = Color(0xFF151516);
const Color _textDarkColor = Color(0xFFF4F4FA);

const Color mostUsedColor = Color(0xFF979595);

const int _appPrimaryColorValue = 0xFF79479f;
const MaterialColor appPrimarySwatch =
    MaterialColor(_appPrimaryColorValue, <int, Color>{
  50: Color(0xff956db4),
  100: Color(0xff885baa),
  200: Color(0xff7b49a1),
  300: Color(_appPrimaryColorValue),
  400: Color(0xff7b49a1),
  500: Color(0xff6f4291),
  600: Color(0xff623a81),
  700: Color(0xff563371),
  800: Color(0xff4a2c61),
  900: Color(0xff3e2551),
});

final typography = Typography.material2014();

TextTheme _lightTextTheme(Typography typography) {
  final textTheme = typography.black;
  return textTheme.apply(
    fontFamily: _appFontFamily,
    displayColor: _textLightColor,
    bodyColor: _textLightColor,
  );
}

TextTheme _darkTextTheme(Typography typography) {
  final textTheme = typography.white;
  return textTheme.apply(
    fontFamily: _appFontFamily,
    displayColor: _textDarkColor,
    bodyColor: _textDarkColor,
  );
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: _appFontFamily,
  typography: typography,
  primarySwatch: appPrimarySwatch,
  primaryColor: Color(_appPrimaryColorValue),
  accentColorBrightness: Brightness.dark,
  textTheme: _lightTextTheme(typography),
  canvasColor: const Color(0xFFEDF2FA),
  accentColor: const Color(0xFFFD9833),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: const EdgeInsets.only(left: 12, right: 8),
    filled: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: Color(_appPrimaryColorValue),
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: _appFontFamily,
  typography: typography,
  primarySwatch: appPrimarySwatch,
  primaryColor: Color(_appPrimaryColorValue),
  accentColorBrightness: Brightness.dark,
  textTheme: _darkTextTheme(typography),
  accentColor: const Color(0xFFFD9833),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: const EdgeInsets.only(left: 12, right: 8),
    filled: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    backgroundColor: Color(_appPrimaryColorValue),
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
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
