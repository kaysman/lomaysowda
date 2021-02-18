import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/categories.dart';
import 'package:lomaysowdamuckup/model/language.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/model/product_detail.dart';
import 'package:lomaysowdamuckup/model/product_provider.dart';
import 'package:lomaysowdamuckup/model/slider.dart';
import 'package:lomaysowdamuckup/model/unit.dart';

typedef Future<List<Product>> SearchProduct({
  @required final String query,
});

typedef Future<List<Product>> FetchProduct({
  @required final String api,
});

typedef Future<ProductDetail> FetchProductDetail({
  @required final int id,
});

typedef Future<ProductProvider> FetchProductProvider({
  @required final int id,
});

typedef Future<List> FetchAllProducts({
  @required final String api,
});

typedef Future<List<SliderImage>> FetchSliderImages({
  @required final String api,
});

typedef Future<List<Category>> FetchCategories();
typedef Future<List<Unit>> FetchUnits();
typedef Future<List<Product>> FetchCategoryResult({@required int id});

class MyProvider with ChangeNotifier {
  Language _lang;

  // product detail by id
  ProductDetail _productDetail;
  FetchProductDetail _fetchProductDetail;

  // product provider
  ProductProvider _productProvider;
  FetchProductProvider _fetchProductProvider;

  // search products
  List<Product> _searchProducts;
  SearchProduct _searchResult;

  // vip and trand products
  FetchProduct _fetchProduct;
  List<Product> _vipProducts;
  List<Product> _trandProducts;

  // products
  List<Product> _allProducts;
  FetchAllProducts _fetchAllProducts;
  String _nextLink; // next page link

  // sliders
  FetchSliderImages _fetchSliderImages;
  List<SliderImage> _sliderImages;

  // categories
  List<Category> _categories;
  FetchCategories _fetchCategories;
  // unit
  List<Unit> _units;
  FetchUnits _fetchUnits;

  // category result
  List<Product> _categoryResult;
  FetchCategoryResult _fetchCategoryResult;

  MyProvider({
    @required FetchProduct fetchProduct,
    @required FetchSliderImages fetchSliderImages,
    @required FetchAllProducts fetchAllProducts,
    @required FetchProductDetail fetchProductDetail,
    @required FetchProductProvider fetchProductProvider,
    @required FetchCategories fetchCategories,
    @required FetchCategoryResult fetchCategoryResult,
    @required FetchUnits fetchUnits,
    @required SearchProduct searchProduct,
  }) {
    assert(fetchProduct != null);
    assert(fetchSliderImages != null);
    assert(fetchAllProducts != null);
    assert(fetchProductDetail != null);
    assert(fetchProductProvider != null);
    assert(fetchCategories != null);
    assert(fetchCategoryResult != null);
    assert(fetchUnits != null);
    assert(searchProduct != null);
    this._fetchProduct = fetchProduct;
    this._fetchSliderImages = fetchSliderImages;
    this._fetchAllProducts = fetchAllProducts;
    this._fetchProductDetail = fetchProductDetail;
    this._fetchProductProvider = fetchProductProvider;
    this._fetchCategories = fetchCategories;
    this._fetchCategoryResult = fetchCategoryResult;
    this._fetchUnits = fetchUnits;
    this._searchResult = searchProduct;
  }

  Future<List<Product>> getVipProducts({
    @required final String api,
  }) async {
    List<Product> products = await this._fetchProduct(api: api);
    this._vipProducts = products;
    this.notifyListeners();
    return this._vipProducts;
  }

  Future<List<Product>> getTrandProducts({
    @required final String api,
  }) async {
    List<Product> products = await this._fetchProduct(api: api);
    this._trandProducts = products;
    this.notifyListeners();
    return this._trandProducts;
  }

  Future<List<Product>> getAllProducts({
    @required final String api,
  }) async {
    List list = await this._fetchAllProducts(api: api);
    List<Product> products = list[0];
    String nextLink = list[1]['next'];
    this._nextLink = nextLink;
    if (this._allProducts == null) {
      this._allProducts = products;
    } else {
      this._allProducts.addAll(products);
    }
    this.notifyListeners();
    return this._allProducts;
  }

  Future<List<SliderImage>> getSliderImages({
    @required final String api,
  }) async {
    List<SliderImage> sliderImages = await this._fetchSliderImages(api: api);
    this._sliderImages = sliderImages;
    this.notifyListeners();
    return this._sliderImages;
  }

  Future<ProductDetail> getProductDetail({
    @required int id,
  }) async {
    ProductDetail product = await this._fetchProductDetail(id: id);
    this._productDetail = product;
    this.notifyListeners();
    return this._productDetail;
  }

  Future<ProductProvider> getProductProvider({@required int id}) async {
    ProductProvider provider = await this._fetchProductProvider(id: id);
    this._productProvider = provider;
    this.notifyListeners();
    return this._productProvider;
  }

  Future<List<Category>> getCategories() async {
    List<Category> categories = await this._fetchCategories();
    this._categories = categories;
    this.notifyListeners();
    return this._categories;
  }

  Future<List<Unit>> getUnits() async {
    List<Unit> units = await this._fetchUnits();
    this._units = units;
    this.notifyListeners();
    return this._units;
  }

  Future<List<Product>> getCategoryResult({@required int id}) async {
    List<Product> categoryResult = await this._fetchCategoryResult(id: id);
    this._categoryResult = categoryResult;
    this.notifyListeners();
    return this._categoryResult;
  }

  Future<List<Product>> searchProducts({@required String query}) async {
    var result = await this._searchResult(query: query);
    this._searchProducts = result;
    return this._searchProducts;
  }

  void setLang(Language language) {
    this._lang = language;
    this.notifyListeners();
  }

  // GETTERS

  // product detail
  ProductDetail get productDetail => this._productDetail;
  // product provider
  ProductProvider get productProvider => this._productProvider;
  // products
  List<Product> get vipProducts => this._vipProducts;
  List<Product> get allProducts => this._allProducts;
  List<Product> get trandProducts => this._trandProducts;

  // categories
  List<Category> get categories => this._categories;
  // category result
  List<Product> get categoryResult => this._categoryResult;

  // slider images
  List<SliderImage> get sliderImages => this._sliderImages;

  // get search results
  List<Product> get searchResult => this._searchProducts;

  // get link
  String get link => this._nextLink;

  // locale
  String get locale => this._lang == null ? 'tk' : this._lang.languageCode;
}
