import 'package:flutter/material.dart';
import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/models/slider.dart';
import 'package:lomaysowda/services/products_service.dart';
import 'package:lomaysowda/services/slider_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  int _page;
  List<SliderModel> sliders = [];
  List<ProductItemModel> vipProducts = [];
  List<ProductItemModel> trandProducts = [];
  List<ProductItemModel> allProducts = [];

  HomeProvider() {
    initData();
  }

  Future<void> initData({bool refresh = false}) async {
    _page = 1;
    SliderListModel sliderResponse = await SliderAPI.getSlidersData();
    ProductListModel vipResponse =
        await ProductsGridAPI.getProductsData("vip-products");
    ProductListModel trandResponse =
        await ProductsGridAPI.getProductsData("trand-products");
    ProductListModel allResponse =
        await ProductsGridAPI.getProductsData("all-products?page=$_page");

    sliders = sliderResponse.list;
    vipProducts = vipResponse.list;
    trandProducts = trandResponse.list;
    allProducts = allResponse.list;
    loading = false;
    _page = 2;

    if (refresh) {
      sliders = sliderResponse.list;
      vipProducts = vipResponse.list;
      trandProducts = trandResponse.list;
      allProducts = allResponse.list;
      loading = false;
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

  Future loadData({bool refresh = false}) async {
    ProductListModel allResponse =
        await ProductsGridAPI.getProductsData("all-products?page=$_page");
    allProducts += allResponse.list;
    loading = false;
    if (allProducts.length < 100) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    _page += 1;
    notifyListeners();
  }
}
