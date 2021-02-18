import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/add_product/add_product_screen.dart';
import 'package:lomaysowdamuckup/screens/category/category_screen.dart';
import 'package:lomaysowdamuckup/screens/home/components/allCatalog.dart';
import 'package:lomaysowdamuckup/screens/home/components/slider_part.dart';
import 'package:lomaysowdamuckup/screens/home/components/trandCatalog.dart';
import 'package:lomaysowdamuckup/screens/home/components/vipCatalog.dart';
import 'package:lomaysowdamuckup/utils.dart';
import 'package:provider/provider.dart';
import '../app_bar/appBar.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    BodyPart(),
    AddProductPage(),
    CategoryScreen()
  ];
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> streamSubscription;
  String _connectionStatus;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    S.load(Locale('tk', 'TM'));
    connectivity = Connectivity();
    streamSubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    // final delegate = S.of(context);

    const List<Map<String, Widget>> _tabBarData = [
      {
        "image": Icon(Icons.home),
        "selectedImage": Icon(Icons.home),
      },
      {
        "image": SizedBox(
          child: Text('Add Product'),
        ),
        "selectedImage": Icon(Icons.home),
      },
      {
        "image": Icon(Icons.category),
        "selectedImage": Icon(Icons.home),
      },
    ];
    final delegate = S.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          unselectedItemColor: kPrimaryColor,
          selectedItemColor: kPrimaryColor,
          selectedLabelStyle: TextStyle(
            fontSize: 0,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Container(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.home),
                  ],
                ),
              ),
              activeIcon: Stack(
                children: <Widget>[
                  Icon(Icons.home),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Container(
                height: MediaQuery.of(context).size.height * 0.073,
                color: Color(0xfff15353),
                child: Center(
                  child: Text(
                    delegate.add_product_add,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat-Bold',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Container(
                child: Icon(Icons.menu),
              ),
            ),
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}

class BodyPart extends StatefulWidget {
  const BodyPart({
    Key key,
  }) : super(key: key);

  @override
  _BodyPartState createState() => _BodyPartState();
}

class _BodyPartState extends State<BodyPart> {
  ScrollController _scrollController;
  MyProvider _provider;
  Widget _progress = Text('');

  _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      String link = _provider.link;
      if (link != null) {
        setState(() {
          _progress = CircularProgressIndicator(strokeWidth: 2);
        });
        await _provider.getAllProducts(api: link);
      }
    }
  }

  @override
  void initState() {
    _provider = Provider.of<MyProvider>(context, listen: false);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      appBar: homeAppBar(context, title: 'Home'),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.21,
                      width: MediaQuery.of(context).size.width,
                      child: SliderPart(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                        child: Text(delegate.vip_products,
                            style: Commons.headingTextStyle)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
                      color: Color(0xFFEBE7F7),
                      child: VipCatalog(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Text(delegate.trand_products,
                          style: Commons.headingTextStyle),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: TrandCatalog()),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                        child: Text(delegate.all_products,
                            style: Commons.headingTextStyle)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(child: AllCatalog()),
                    Center(
                      child: Container(
                        width: 45,
                        height: 45,
                        child: _progress,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
