import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/main/provider/theme_provider.dart';

CustomTheme currentTheme = CustomTheme();

const String _appFontFamily = 'Montserrat';
const Color _textLightColor = Color(0xFF151516);
const Color mostUsedColor = Color(0xFF979595);

const int _appPrimaryColorValue = 0xFF79479f;
const MaterialColor appPrimarySwatch =
    MaterialColor(_appPrimaryColorValue, <int, Color>{
  50: Color(0xff956db4),
  100: Color(0xff885baa),
  200: Color(0xff7b49a1),
  300: Color(0xff7b49a1),
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

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(_appPrimaryColorValue),
  brightness: Brightness.light,
  accentColorBrightness: Brightness.dark,
  textTheme: _lightTextTheme(typography),
  fontFamily: _appFontFamily,
  typography: typography,
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

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.red),
  dividerColor: Colors.black12,
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
