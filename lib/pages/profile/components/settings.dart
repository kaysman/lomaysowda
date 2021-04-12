import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/config/custom_theme.dart';
import 'package:lomaysowda/pages/profile/provider/theme_provider.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'select_language.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              MyNavigator.push(LanguageSelectPage());
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.language_outlined),
                title: Row(
                  children: [
                    Text('language'.tr),
                    Spacer(),
                    Text("${Get.locale.languageCode}"),
                  ],
                ),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.wb_sunny_outlined),
              title: Row(
                children: [
                  Text('dark'.tr),
                  Spacer(),
                  CupertinoSwitch(
                    value: themeNotifier.getTheme == darkTheme,
                    onChanged: (value) async {
                      (value)
                          ? themeNotifier.setTheme(darkTheme)
                          : themeNotifier.setTheme(lightTheme);
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool('darkMode', value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
