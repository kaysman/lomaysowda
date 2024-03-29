import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:lomaysowda/pages/category/category_page.dart';
import 'package:lomaysowda/pages/home/home_page.dart';
import 'package:lomaysowda/pages/main/provider/main_provider.dart';
import 'package:lomaysowda/pages/add_product/product_add_page.dart';
import 'package:lomaysowda/pages/profile/profile_page.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/my_bottom_navbar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 750), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mainState = Provider.of<MainProvider>(context);
    MyNavigator.ctx = context;
    ScreenUtil.init(
      context,
      width: 375,
      height: 812 - 44 - 34,
      allowFontScaling: true,
    );
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        onTap: (index) {
          mainState.tabBarPageController.jumpToPage(index);
          setState(() {
            mainState.setTabBarSelectedIndex = index;
          });
        },
      ),
      body: PageView(
        controller: mainState.tabBarPageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          CategoryPage(),
          ProductAddPage(),
          ProfilePage(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
