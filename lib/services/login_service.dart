import 'package:lomaysowda/utils/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  static Future<bool> loginService({Map<String, String> data}) async {
    var response = await RequestUtil().post('auth/login', params: data);
    if (response['access_token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response['access_token']);
      return true;
    } else {
      return false;
    }
  }
}
