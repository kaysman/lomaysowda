import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/brand.dart';
import 'package:lomaysowdamuckup/model/order.dart';
import 'package:lomaysowdamuckup/model/product.dart';
import 'package:lomaysowdamuckup/model/user.dart';
import 'package:lomaysowdamuckup/networking/app_url.dart';
import 'package:lomaysowdamuckup/provider/typedef.dart';

// typedef Future<Brand> ();

class Session with ChangeNotifier {
  // isLogging
  bool _isLogging = false;
  bool get isLogging => this._isLogging;

  User _user;
  String _token;
  DateTime _fetchTime;
  List<Brand> _userBrands = [];
  List<Product> _userProducts = [];
  List<Order> _userOrders = [];
  AuthenticatedUser _authenticatedUser;

  // methods
  SignIn _signIn;
  SignOut _signOut;
  Register _register;
  AuthUserProducts _getUserProducts;
  AuthUserBrands _getUserBrands;
  AuthUserOrders _getUserOrders;

  // update me
  UpdateMe _updateMe;

  // Add product
  AddProduct _addProduct;
  bool _productAdded = false;
  bool get productAdded => this._productAdded;

  // update product
  bool _goodUpdated;
  bool _goodAddedImg;
  bool _goodDeletedImg;
  UpdateProduct _updateProduct;
  UpdateProductAddImage _updateProductAddImage;
  UpdateProductDeleteImage _updateProductDeleteImage;

  // delete product
  DeleteProduct _deleteProduct;

  // Add Brand
  AddBrand _addBrand;
  bool _brandAdded = false;
  bool get brandAdded => this._brandAdded;
  // edit brand
  EditBrand _editBrand;
  // delete
  DeleteBrand _deleteBrand;

  Session({
    @required String token,
    @required User user,
    @required SignIn signIn,
    @required SignOut signOut,
    @required UpdateMe updateMe,
    @required AuthenticatedUser authenticatedUser,
    @required Register register,
    @required AuthUserProducts getUserProducts,
    @required AuthUserBrands getUserBrands,
    @required AuthUserOrders getUserOrders,
    @required AddProduct addProduct,
    @required UpdateProduct updateProduct,
    @required UpdateProductAddImage updateProductAddImage,
    @required UpdateProductDeleteImage updateProductDeleteImage,
    @required AddBrand addBrand,
    @required EditBrand editBrand,
    @required DeleteProduct deleteProduct,
    @required DeleteBrand deleteBrand,
  }) {
    assert(signIn != null);
    assert(signOut != null);
    assert(authenticatedUser != null);
    assert(register != null);
    assert(updateMe != null);
    assert(getUserProducts != null);
    assert(getUserBrands != null);
    assert(getUserOrders != null);
    assert(addProduct != null);
    assert(addBrand != null);
    assert(updateProduct != null);
    assert(updateProductAddImage != null);
    assert(updateProductDeleteImage != null);
    assert(editBrand != null);
    assert(deleteProduct != null);
    assert(deleteBrand != null);
    this._token = token;
    this._user = user;
    this._signIn = signIn;
    this._signOut = signOut;
    this._updateMe = updateMe;
    this._authenticatedUser = authenticatedUser;
    this._register = register;
    this._addProduct = addProduct;
    this._updateProduct = updateProduct;
    this._updateProductAddImage = updateProductAddImage;
    this._updateProductDeleteImage = updateProductDeleteImage;
    this._deleteProduct = deleteProduct;
    this._editBrand = editBrand;
    this._addBrand = addBrand;
    this._deleteBrand = deleteBrand;
    this._getUserProducts = getUserProducts;
    this._getUserBrands = getUserBrands;
    this._getUserOrders = getUserOrders;
    this._fetchTime = DateTime.fromMillisecondsSinceEpoch(0);
  }

  // session sign in method
  Future<void> signIn(
      {@required final String email, @required final String password}) async {
    this._isLogging = true;
    this.notifyListeners();
    final List list = await this._signIn(email: email, password: password);
    this._token = list[0];
    this._fetchTime = list[1];
    this.notifyListeners();
    final User user = await this._authenticatedUser(token: this._token);
    this._user = user;
    this._isLogging = false;
    this.notifyListeners();
  }

  // register
  Future<void> register({
    @required Map<String, dynamic> data,
    @required Map<String, File> files,
  }) async {
    assert(data != null);
    assert(files != null);
    this._isLogging = true;
    this.notifyListeners();
    bool isRegistered = await this._register(
        url: AppUrl.baseURL + 'auth/registration', data: data, files: files);
    if (isRegistered) {
      this.signIn(email: data['email'], password: data['password']);
    } else {
      this._isLogging = false;
      this.notifyListeners();
    }
  }

  // update me
  Future<bool> updateMe({
    @required int id,
    @required Map<String, String> data,
    Map<String, File> files,
  }) async {
    assert(data != null);
    bool updated = await this._updateMe(id: id, data: data, files: files);
    return updated;
  }

  // get authenticated user's products
  Future<List<Product>> getUserProducts() async {
    assert(this._user != null);
    final List<Product> userProducts = await this._getUserProducts();
    this._userProducts = userProducts;
    this.notifyListeners();
    return this._userProducts;
  }

  // get authenticated user's brands
  Future<List<Brand>> getUserBrands() async {
    assert(this._user != null);
    final List<Brand> userBrands = await this._getUserBrands();
    this._userBrands = userBrands;
    this.notifyListeners();
    return this._userBrands;
  }

  // get authenticated user's orders
  Future<List<Order>> getUserOrders() async {
    assert(this._user != null);
    final List<Order> orders = await this._getUserOrders();
    this._userOrders = orders;
    this.notifyListeners();
    return this._userOrders;
  }

  // get authenticated user's orders
  Future<bool> addProduct({
    @required Map<String, dynamic> data,
    @required Map<String, List<File>> files,
  }) async {
    assert(this._user != null);
    assert(data != null);
    assert(files != null);
    final bool added = await this._addProduct(data: data, files: files);
    this._productAdded = added;
    this.notifyListeners();
    return this._productAdded;
  }

  // update product data
  Future<bool> updateProduct({
    @required Map<String, dynamic> data,
  }) async {
    assert(this._user != null);
    assert(data != null);
    final bool updated = await this._updateProduct(data: data);
    this._goodUpdated = updated;
    this.notifyListeners();
    return this._goodUpdated;
  }

  // add product image
  Future<bool> updateProductAddImage({
    @required Map<String, File> file,
  }) async {
    assert(this._user != null);
    assert(file != null);
    final bool updatedImg = await this._updateProductAddImage(file: file);
    this._goodAddedImg = updatedImg;
    this.notifyListeners();
    return this._goodAddedImg;
  }

  // delete product image
  Future<bool> updateProductDeleteImage({
    @required int id,
    @required int imgId,
  }) async {
    assert(this._user != null);
    assert(id != null);
    assert(imgId != null);
    final bool updatedImg =
        await this._updateProductDeleteImage(id: id, imgId: imgId);
    this._goodDeletedImg = updatedImg;
    this.notifyListeners();
    return this._goodDeletedImg;
  }

  // delete product
  Future<bool> deleteProduct({@required int id}) async {
    final bool deleted = await this._deleteProduct(id: id);
    return deleted;
  }

  // add brand
  Future<bool> addBrand({
    @required Map<String, dynamic> data,
    Map<String, File> files,
  }) async {
    assert(this._user != null);
    assert(data != null);
    assert(files != null);
    final bool added = await this._addBrand(data: data, files: files);
    this._brandAdded = added;
    this.notifyListeners();
    return this._brandAdded;
  }

  // edit brand
  Future<bool> editBrand({
    @required int id,
    @required Map<String, dynamic> data,
    Map<String, File> files,
  }) async {
    assert(this._user != null);
    assert(data != null);
    final bool edited = await this._editBrand(id: id, data: data, files: files);
    return edited;
  }

  // delete brand
  Future<bool> deleteBrand({@required int id}) async {
    final bool deleted = await this._deleteBrand(id: id);
    return deleted;
  }

  // session sign out method
  Future<void> signOut() async {
    this._user = null;
    await this._signOut();
    this.notifyListeners();
  }

  // GETTERS

  User get authenticatedUser {
    return this._user != null ? this._user : null;
  }

  List<Product> get userProducts {
    return this._user != null ? this._userProducts : null;
  }

  List<Brand> get userBrands {
    return this._user != null ? this._userBrands : null;
  }

  List<Order> get userOrders {
    return this._user != null ? this._userOrders : null;
  }

  DateTime get fetchTime => this._fetchTime;
}
