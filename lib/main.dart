import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:lomaysowda/translations/binding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/custom_theme.dart';
import 'pages/add_product/provider/addproduct_provider.dart';
import 'pages/add_product/provider/image_provider.dart';
import 'pages/category/provider/category_provider.dart';
import 'pages/main/main_page.dart';
import 'pages/main/provider/main_provider.dart';
import 'pages/my_brands.dart/provider/getbrands_provider.dart';
import 'pages/profile/provider/theme_provider.dart';
import 'pages/profile/provider/user_provider.dart';
import 'translations/app_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then(
    (prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      var selectedLang = prefs.getString('language') ?? 'ru';
      var isLogged = prefs.getString('token') == null ? false : true;
      return runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainProvider()),
            ChangeNotifierProvider(
              create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
            ),
            ChangeNotifierProvider(create: (_) => CategoryProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider(user: isLogged)),
            ChangeNotifierProvider(create: (_) => AddProductProvider()),
            ChangeNotifierProvider(create: (_) => GetBrandsProvider()),
            ChangeNotifierProvider(create: (_) => MyImageProvider())
          ],
          child: LOMAYAPP(lang: selectedLang),
        ),
      );
    },
  );

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class LOMAYAPP extends StatelessWidget {
  final String lang;

  const LOMAYAPP({Key key, this.lang}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GetMaterialApp(
      translationsKeys: AppTranslation.translationKeys,
      locale:
          lang == null ? Get.deviceLocale : Locale(lang, lang.toUpperCase()),
      fallbackLocale: Locale('ru', 'RU'),
      title: "Lomaysowda Application",
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      initialBinding: LanguageBinding(),
      theme: themeNotifier.getTheme,
      home: MainPage(),
    );
  }
}
