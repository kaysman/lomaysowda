import 'package:dio/dio.dart';
import 'package:lomaysowda/models/brand.dart';
import 'package:lomaysowda/models/order.dart';
import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/utils/request.dart';

class UserApi {
  static Future<ProductListModel> getUserProducts(String url) async {
    var response = await RequestUtil().get(url, auth: true);
    return ProductListModel.fromJson(response['data']);
  }

  static Future<BrandListModel> getUserBrands(String url) async {
    var response = await RequestUtil().get(url, auth: true);
    return BrandListModel.fromJson(response['data']);
  }

  static Future<OrderModelList> getUserOrders(String url) async {
    var response = await RequestUtil().get(url, auth: true);
    return OrderModelList.fromJson(response['data']);
  }

  static Future addUserProduct({dynamic params}) async {
    var response = await RequestUtil().post(
      'store/product',
      params: params,
      auth: true,
      options: Options(
        contentType: 'multipart/form-data',
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );
    return response['message'];
  }
}
