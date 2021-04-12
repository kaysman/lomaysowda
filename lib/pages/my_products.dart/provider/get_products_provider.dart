import 'package:flutter/widgets.dart';
import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/services/products_service.dart';
import 'package:lomaysowda/services/user_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetProductsProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<ProductItemModel> userProducts = [];
  bool loading = true;
  int _page;

  GetProductsProvider() {
    getUserProducts();
  }

  Future getUserProducts({bool refresh = false}) async {
    _page = 1;
    String token = await UserPreferences().getToken();
    if (token != null) {
      Map<String, String> myParams = {'Authorization': "Bearer $token"};
      ProductListModel res = await ProductsGridAPI.getProductsData(
          'auth/my-products',
          params: myParams);
      userProducts = res.list;
    }
    loading = false;
    _page = 2;
    if (refresh) {
      if (token != null) {
        Map<String, String> myParams = {'Authorization': "Bearer $token"};
        ProductListModel res = await ProductsGridAPI.getProductsData(
            'auth/my-products?page=$_page',
            params: myParams);
        userProducts = res.list;
      }
      loading = false;
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

  Future loadMoreProducts({bool refresh = false}) async {
    var token = await UserPreferences().getToken();
    if (token != null) {
      Map<String, String> myParams = {'Authorization': "Bearer $token"};
      ProductListModel res = await ProductsGridAPI.getProductsData(
          'auth/my-products?page=$_page',
          params: myParams);
      userProducts += res.list;
    }
    loading = false;
    if (userProducts.length < 100) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    _page += 1;
    notifyListeners();
  }
}
