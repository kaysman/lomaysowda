import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/pages/login/login_page.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:provider/provider.dart';
import 'components/list_of_tiles.dart';
import 'components/logged_top.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, state, child) {
        print('profile has user');
        print(state.getUser);
        return state.getUser ? ProfilePageContainer() : LoginPage();
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
                LoggedProfileTop(),
                ProfileTileList(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
