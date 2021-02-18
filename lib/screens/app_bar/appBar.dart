import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/language.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/search_bar/search_bar.dart';
import 'package:lomaysowdamuckup/screens/profile/profile.dart';
import 'package:provider/provider.dart';

AppBar homeAppBar(BuildContext context, {@required String title}) {
  Session session = Provider.of<Session>(context);
  final delegate = S.of(context);
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    title: title == 'Home'
        ? Container(
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/logo.png',
              width: 40,
              height: 40,
            ),
          )
        : Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Bold',
              fontSize: 17,
            ),
          ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: kPrimaryLightColor,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchBar(hintText: delegate.search_bar_label),
                );
              }),
          IconButton(
            icon: session.authenticatedUser == null
                ? Icon(
                    Icons.person,
                    color: kPrimaryLightColor,
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(session.authenticatedUser.image),
                  ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Profile(),
                ),
              );
            },
          ),
          // _itemDown(),
          IconButton(
            icon: Icon(
              Icons.language,
              color: kPrimaryLightColor,
            ),
            onPressed: () {
              return showDialog(
                context: context,
                child: Dialog(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: Language.languageList()
                          .map((lang) => Center(
                                child: GestureDetector(
                                  onTap: () {
                                    S.load(Locale(
                                        lang.languageCode, lang.countryCode));
                                    Navigator.of(context).pop();
                                    // Provider.of<MyProvider>(context).setLang(lang);
                                  },
                                  child: ListTile(
                                    dense: true,
                                    leading: Text(lang.flag),
                                    title: Text(lang.name),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
