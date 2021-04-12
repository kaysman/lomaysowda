import 'package:lomaysowda/services/user_preferences.dart';
import 'package:lomaysowda/utils/request.dart';

class LoginAPI {
  static Future<bool> loginService({Map<String, String> data}) async {
    var response = await RequestUtil().post('auth/login', params: data);
    if (response['access_token'] != null) {
      await UserPreferences().saveToken(response['access_token']);
      await UserPreferences().saveLogin(true);
      return true;
    } else {
      return false;
    }
  }
}
