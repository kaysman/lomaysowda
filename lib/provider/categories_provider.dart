import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/categories.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  Duration _cacheValidDuration;
  DateTime _lastFetchTime;
  List<Category> _categories;

  CategoriesProvider() {
    _cacheValidDuration = Duration(minutes: 30);
    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
    _categories = [];
  }

  List<Category> get categories => _categories;

  Future<void> refreshRecords(bool notifyListeners) async {
    final response = await http.get('http://lomaysowda.com.tm/api/categories');
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      _categories = Category.listFromJson(json['data']);
      _lastFetchTime = DateTime.now();
      if (notifyListeners) this.notifyListeners();
    } else {
      print('categories/ error occurred, bro');
    }
  }

  Future<List<Category>> fetchCategories({bool forceRefresh = false}) async {
    bool shouldRefresh = (_categories == null) ||
        (_categories.isEmpty) ||
        (_lastFetchTime == null) ||
        (_lastFetchTime
            .isBefore(DateTime.now().subtract(_cacheValidDuration))) ||
        forceRefresh;
    if (shouldRefresh) await refreshRecords(false);
    return _categories;
  }
}
