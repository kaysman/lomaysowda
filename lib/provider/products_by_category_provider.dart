import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lomaysowdamuckup/model/product_detail.dart';

class CategoryProductsProvider extends ChangeNotifier {
  Duration _cacheValidDuration;
  DateTime _lastFetchTime;
  Map<int, List<ProductDetail>> _allProducts;
  int _categoryId;

  CategoryProductsProvider() {
    _cacheValidDuration = Duration(minutes: 30);
    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
    _allProducts = {};
  }

  int get categoryId => _categoryId;

  set setCatId(int id) {
    _categoryId = id;
    notifyListeners();
  }

  Future<void> refreshProducts(bool notifyListeners) async {
    final response = await http
        .get('http://lomaysowda.com.tm/api/category/' + '$_categoryId');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      _allProducts[_categoryId] = jsonData['data'];
      _lastFetchTime = DateTime.now();
      if (notifyListeners) this.notifyListeners();
    } else {
      print('Sliders/ error occured');
    }
  }

  Future<List<ProductDetail>> fetchProductsByCategory(int id,
      {bool forceRefresh = false}) async {
    bool shouldRefresh = (_allProducts[id] == null) ||
        (_allProducts[id].isEmpty) ||
        (_lastFetchTime == null) ||
        (_lastFetchTime
            .isBefore(DateTime.now().subtract(_cacheValidDuration))) ||
        forceRefresh;
    if (shouldRefresh) await refreshProducts(false);
    print(_allProducts[id].length);
    return _allProducts[id];
  }
}
