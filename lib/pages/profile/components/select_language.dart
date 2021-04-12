import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/models/language.dart';
import 'package:lomaysowda/pages/profile/provider/language_controller.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LanguageController _controller = Get.find<LanguageController>();

    return Scaffold(
      appBar: MyAppBar(
        context: context,
        backgroundColor: Theme.of(context).cardColor,
        leadingType: AppBarBackType.Back,
        title: Text('select_language'.tr),
      ),
      body: Container(
        child: ListView(
          children: languages.map((lang) {
            return InkWell(
              onTap: () async {
                _controller.changeLanguage = lang.symbol;
                var prefs = await SharedPreferences.getInstance();
                prefs.setString('language', lang.symbol);
              },
              child: Card(
                child: ListTile(
                  leading: Text(lang.symbol),
                  title: Text(lang.language),
                  trailing: lang.symbol == Get.locale.languageCode
                      ? SvgPicture.asset(
                          "assets/icons/tick.svg",
                          height: 35,
                          color: Theme.of(context).accentColor,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
