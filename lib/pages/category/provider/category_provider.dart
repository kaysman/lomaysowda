import 'package:flutter/material.dart';
import 'package:lomaysowda/models/category.dart';
import 'package:lomaysowda/models/unit.dart';
import 'package:lomaysowda/services/category_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  List<CategoryModel> categories = [];
  List<UnitModel> units = [];

  CategoryProvider() {
    initData();
  }

  Future<void> initData({bool refresh = false}) async {
    CategoryModelList categoryResponse = await CategoryAPI.getCategoryData();
    UnitModelList res = await CategoryAPI.getUnits();
    categories = categoryResponse.list;
    units = res.list;
    loading = false;

    if (refresh) {
      categories = categoryResponse.list;
      units = res.list;
      loading = false;
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }
}
