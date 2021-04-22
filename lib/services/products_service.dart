import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/utils/request.dart';

class ProductsGridAPI {
  static Future<ProductListModel> getProductsData(String route,
      {params}) async {
    var response = await RequestUtil().get(route, params: params);
    return ProductListModel.fromJson(response['data']);
  }

  static Future<ProductListModel> searchProduct(
      String route, String query) async {
    Map<String, String> data = {'search': query};
    var response = await RequestUtil().post(route, params: data);
    // var response = await RequestUtil().get(route);
    return ProductListModel.fromJson(response['data']);
  }
}
