import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  // Page Controller
  final PageController tabBarPageController = PageController(initialPage: 0);
  // tabbar
  int _tabBarSelectedIndex = 0;
  int get getTabBarSelectedIndex => _tabBarSelectedIndex;
  set setTabBarSelectedIndex(int value) {
    tabBarPageController.animateToPage(
      value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _tabBarSelectedIndex = value;
    notifyListeners();
  }

  int _messageCount = 0;

  String get getMessageCount =>
      _messageCount < 100 ? _messageCount.toString() : "99+";
  bool get isMessageCount => _messageCount > 0;
}
