import 'package:flutter/foundation.dart';
import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/services/products_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  int _page;
  String query;
  List<ProductItemModel> products = [];

  SearchProvider({this.query}) {
    getData();
  }

  Future<void> getData({bool refresh = false}) async {
    _page = 1;
    ProductListModel response =
        await ProductsGridAPI.searchProduct("search?page=$_page", query);
    products = response.list;
    loading = false;
    _page = 2;
    if (refresh) {
      products = response.list;
      loading = false;
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

  Future loadData({bool refresh = false}) async {
    ProductListModel response =
        await ProductsGridAPI.searchProduct("search?page=$_page", query);
    products += response.list;
    loading = false;
    if (products.length < 100) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    _page += 1;
    notifyListeners();
  }
}
