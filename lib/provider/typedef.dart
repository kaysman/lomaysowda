import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/brand.dart';
import 'package:lomaysowdamuckup/model/order.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/model/user.dart';

typedef Future<List> SignIn({
  @required final String email,
  @required final String password,
});
// update me
typedef Future<bool> UpdateMe({
  @required int id,
  @required Map<String, String> data,
  @required Map<String, File> files,
});

// product
typedef Future<bool> AddProduct({
  @required Map<String, dynamic> data,
  @required Map<String, List<File>> files,
});
// update product
typedef Future<bool> UpdateProduct({
  @required int id,
  @required Map<String, dynamic> data,
});
// add product image
typedef Future<bool> UpdateProductAddImage({
  @required int id,
  @required Map<String, File> file,
});
// delete product image
typedef Future<bool> UpdateProductDeleteImage({
  @required int id,
  @required int imgId,
});

typedef Future<bool> DeleteProduct({
  @required int id,
});

// brand
typedef Future<bool> AddBrand({
  @required Map<String, dynamic> data,
  @required Map<String, File> files,
});
typedef Future<bool> EditBrand({
  @required int id,
  @required Map<String, dynamic> data,
  Map<String, File> files,
});
typedef Future<bool> DeleteBrand({
  @required int id,
});

typedef Future<bool> Register({
  @required String url,
  @required Map<String, dynamic> data,
  @required Map<String, File> files,
});

typedef Future<User> AuthenticatedUser({
  @required final String token,
});

typedef Future<void> SignOut();

typedef Future<List<Product>> AuthUserProducts();

typedef Future<List<Brand>> AuthUserBrands();

typedef Future<List<Order>> AuthUserOrders();
