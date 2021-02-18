import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/categories.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/model/product_detail.dart';
import 'package:lomaysowdamuckup/model/product_provider.dart';
import 'package:lomaysowdamuckup/model/slider.dart';
import 'package:lomaysowdamuckup/networking/app_url.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:lomaysowdamuckup/model/unit.dart';

final MyProvider myProvider = MyProvider(fetchProduct: ({
  @required final String api,
}) async {
  http.Response response = await http.get(AppUrl.baseURL + api);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Product> products = Product.listFromJson(data['data']);
    return products;
  } else {
    throw Exception('response status code error');
  }
}, fetchSliderImages: ({
  @required final String api,
}) async {
  http.Response response = await http.get(AppUrl.baseURL + api);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<SliderImage> images = SliderImage.listFromJson(jsonData['data']);
    return images;
  } else {
    throw Exception('slider response status code error');
  }
}, fetchAllProducts: ({
  @required String api,
}) async {
  http.Response response = await http.get(api);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Product> products = Product.listFromJson(data['data']);
    Map<String, dynamic> links = data['links'];
    return [products, links];
  } else {
    throw Exception('response status code error');
  }
}, fetchProductDetail: ({
  @required int id,
}) async {
  assert(id != null);
  http.Response response = await http.get(AppUrl.baseURL + 'product/$id');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body)["data"];
    ProductDetail product = ProductDetail.fromJson(data);
    return product;
  } else {
    throw Exception('response status code error');
  }
}, fetchProductProvider: ({@required int id}) async {
  assert(id != null);
  http.Response response = await http.get(AppUrl.baseURL + 'provider/$id');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body)['data'];
    ProductProvider provider = ProductProvider.fromJson(data);
    return provider;
  } else {
    throw Exception('response status code error');
  }
}, fetchCategories: () async {
  http.Response response = await http.get(AppUrl.baseURL + 'categories');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Category> categories = Category.listFromJson(data['data']);
    return categories;
  } else {
    throw Exception('error while getting categories');
  }
}, fetchCategoryResult: ({@required int id}) async {
  assert(id != null);
  http.Response response = await http.get(AppUrl.baseURL + 'category/$id');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Product> products = Product.listFromJson(data['data']);
    return products;
  } else {
    throw Exception('error while getting category result');
  }
}, fetchUnits: () async {
  http.Response response = await http.get(AppUrl.baseURL + 'add/product');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Unit> units = Unit.listFromJson(data['units']);
    return units;
  } else {
    throw Exception('error while getting units');
  }
}, searchProduct: ({@required String query}) async {
  assert(query != null);
  http.Response response = await http.post(
    AppUrl.baseURL + 'search',
    body: {'search': query},
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<Product> results = Product.listFromJson(data['data']);
    return results;
  } else {
    throw Exception('Error while getting searching products');
  }
});
