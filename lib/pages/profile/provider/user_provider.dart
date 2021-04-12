import 'package:flutter/widgets.dart';
import 'package:lomaysowda/services/login_service.dart';
import 'package:lomaysowda/services/user_preferences.dart';

class UserProvider with ChangeNotifier {
  bool loading;
  UserProvider() {
    loading = false;
  }

  Future<bool> login({Map<String, String> data}) async {
    loading = true;
    notifyListeners();
    bool res = await LoginAPI.loginService(data: data);
    loading = false;
    notifyListeners();
    return res;
  }

  Future<void> logout({Map<String, String> data}) async {
    loading = true;
    notifyListeners();
    await UserPreferences().saveToken(null);
    await UserPreferences().saveLogin(null);
    loading = false;
    notifyListeners();
  }
}
