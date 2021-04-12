import 'package:lomaysowda/models/detail.dart';
import 'package:lomaysowda/utils/request.dart';

class DetailAPI {
  static Future<DetailItemModel> getDetailData(int id) async {
    var response = await RequestUtil().get('product/$id');
    return DetailItemModel.fromJson(response['data']);
  }

  static Future<bool> orderProduct(int id, data) async {
    var response = await RequestUtil().post('product/$id/order', params: data);
    print(response);
    return true;
  }
}
