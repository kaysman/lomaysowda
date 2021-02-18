import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/search_bar/search_bar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/anketam/anketam.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/brands.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_orders/orders.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/products.dart';
import 'package:provider/provider.dart';
import '../../constaints.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) {
        return session.authenticatedUser != null ? MyProfile() : LoginScreen();
      },
    );
  }
}

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final delegate = S.of(context);
    return Consumer<Session>(
      builder: (final BuildContext context, final Session session,
          final Widget child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white70),
            elevation: 0,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchBar(hintText: 'Gözleg'));
                    },
                  ),
                ],
              ),
            ],
          ),
          body: Container(
            height: size.height,
            width: size.width,
            color: kPrimaryColor,
            child: ListView(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      NetworkImage(session.authenticatedUser.image),
                ),
                Container(
                  height: size.height * 0.1,
                  width: size.width,
                  child: TitleText(
                    title: session.authenticatedUser.name,
                    email: session.authenticatedUser.email,
                  ),
                ),
                Container(
                  height: size.height * 0.70,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileCatalogContainer(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserProducts()));
                              },
                              text: delegate.my_products.toUpperCase(),
                              path: 'assets/product.png',
                            ),
                            ProfileCatalogContainer(
                              // get user brands
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserBrands()));
                              },
                              text: delegate.my_brands.toUpperCase(),
                              path: 'assets/star.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileCatalogContainer(
                              // get orders made to the user
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UserOrders()));
                              },
                              text: delegate.my_request_me.toUpperCase(),
                              path: 'assets/about3.png',
                            ),
                            ProfileCatalogContainer(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Antekam()));
                              },
                              text: delegate.edit_profile.toUpperCase(),
                              path: 'assets/about1.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            Session session =
                                Provider.of<Session>(context, listen: false);
                            await session.signOut();
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red[100],
                            child: Icon(
                              Icons.logout,
                              size: 25.0,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileCatalogContainer extends StatelessWidget {
  const ProfileCatalogContainer({
    Key key,
    @required this.text,
    @required this.path,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final String path;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.23,
        width: size.width * 0.42,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.07),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontFamily: 'Montserrat-Bold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
