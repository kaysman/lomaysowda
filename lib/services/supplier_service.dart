
import 'package:lomaysowda/models/supplier.dart';
import 'package:lomaysowda/utils/request.dart';

class SupplierAPI {
  static Future<SupplierModel> getSupplierData(int supplierId) async {
    var response = await RequestUtil().get('provider/$supplierId');
    return SupplierModel.fromJson(response['data']);
  }
}
