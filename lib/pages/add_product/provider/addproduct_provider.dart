import 'package:flutter/widgets.dart';
import 'package:lomaysowda/services/user_service.dart';

class AddProductProvider with ChangeNotifier {
  bool loading = false;
  bool isAdded = false;

  Future addUserProduct(data, {bool refresh = false}) async {
    loading = true;
    notifyListeners();
    bool response = await UserApi.addUserProduct(params: data);
    isAdded = response;
    print(response);
    loading = false;
    notifyListeners();
  }
}

// data: {
//    'name_tm': _ady,
//    'cat_id': categories.indexOf(_bolumi),
//    'brand_id': userBrands.indexOf(_markasy),
//    'unit_id': units.indexOf(_unit),
//    'images': images,
// },
