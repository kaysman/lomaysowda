import 'package:lomaysowda/models/slider.dart';
import 'package:lomaysowda/utils/request.dart';

class SliderAPI {
  static Future<SliderListModel> getSlidersData() async {
    var response = await RequestUtil().get('sliders');
    return SliderListModel.fromJson(response['data']);
  }
}
