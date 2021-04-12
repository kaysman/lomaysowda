import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/config/custom_theme.dart';
import 'package:lomaysowda/pages/login/login_page.dart';
import 'package:lomaysowda/pages/profile/components/select_language.dart';
import 'package:lomaysowda/pages/profile/provider/theme_provider.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/label_section.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_divider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/logged_top.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<SharedPreferences> prefsFuture;

  Widget buildContent(BuildContext context, SharedPreferences prefs) {
    final token = prefs?.getString('token');
    return token != null ? ProfilePage() : LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    if (prefsFuture == null) {
      prefsFuture = SharedPreferences.getInstance();
    }
    return FutureBuilder<SharedPreferences>(
      future: prefsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildContent(context, snapshot.data);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProfilePageContainer extends StatefulWidget {
  const ProfilePageContainer({Key key}) : super(key: key);
  @override
  _ProfilePageContainerState createState() => _ProfilePageContainerState();
}

class _ProfilePageContainerState extends State<ProfilePageContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        leadingType: AppBarBackType.None,
        title: Text(
          'settings'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                _buildTop(context),
                _buildFunc(size.height * 0.11),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Background radial gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue,
            Colors.blueAccent,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Consumer<UserProvider>(
        builder: (_, state, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                child: LoggedProfileTop(state: state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFunc(double topMargin) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      margin: EdgeInsets.only(top: topMargin, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: LeftTitle(title: 'Personal'),
          ),
          MyDivider(),
          Consumer<UserProvider>(builder: (_, state, child) {
            return _loggedProfilePersonal();
          }),
          MyDivider(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: LeftTitle(title: 'Settings'),
          ),
          MyDivider(),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: settingsData.map((item) {
                    return _buildIconItem(
                      item['icon'],
                      item['title'],
                      item['count'],
                      onTap: item['onTap'],
                    );
                  }).toList() +
                  [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 35.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'dark'.tr,
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                          ),
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
                  ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loggedProfilePersonal() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: personalData.map((item) {
          return _buildIconItem(
            item['icon'],
            item['title'],
            item['count'],
            onTap: item['onTap'],
          );
        }).toList(),
      ),
    );
  }

  Widget _unloggedProfilePersonal() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoButton(
            onPressed: () {
              MyNavigator.push(LoginPage());
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/pen.svg',
                  color: Colors.blueAccent,
                  height: 18,
                ),
                SizedBox(width: 10),
                Text(
                  'sign in to view your seller account',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(
    String iconData,
    String title,
    dynamic count, {
    Function onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 35.0),
        child: Row(
          children: [
            SvgPicture.asset(
              iconData,
              color: Theme.of(context).accentColor,
              height: 25,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
            Spacer(),
            Text(
              count == null ? '' : count.toString(),
              style: TextStyle(
                fontSize: 15.0,
                color: Theme.of(context).accentColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> personalData = [
  {
    'icon': 'assets/icons/product.svg',
    'title': 'My Products',
    'count': 37,
  },
  {
    'icon': 'assets/icons/star.svg',
    'title': 'My Brands',
    'count': 5,
  },
  {
    'icon': 'assets/icons/orders.svg',
    'title': 'My Orders',
    'count': 13,
  },
];

List<Map<String, dynamic>> settingsData = [
  {
    'icon': 'assets/icons/language.svg',
    'title': 'Language',
    'onTap': () {
      MyNavigator.push(LanguageSelectPage());
    },
  },
];
