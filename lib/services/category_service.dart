import 'package:lomaysowda/models/category.dart';
import 'package:lomaysowda/models/unit.dart';
import 'package:lomaysowda/utils/request.dart';

class CategoryAPI {
  static Future<CategoryModelList> getCategoryData() async {
    var response = await RequestUtil().get('categories');
    return CategoryModelList.fromJson(response['data']);
  }

  static Future<UnitModelList> getUnits() async {
    var response = await RequestUtil().get('add/product');
    return UnitModelList.fromJson(response['units']);
  }
}
