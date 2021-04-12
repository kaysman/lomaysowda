import 'package:flutter/widgets.dart';
import 'package:lomaysowda/services/login_service.dart';
import 'package:lomaysowda/services/user_preferences.dart';

class UserProvider with ChangeNotifier {
  bool loading;
  bool isLoggedIn;
  UserProvider({this.isLoggedIn}) {
    loading = false;
  }

  Future<void> login({Map<String, String> data}) async {
    loading = true;
    notifyListeners();
    bool res = await LoginAPI.loginService(data: data);
    isLoggedIn = res;
    loading = false;
    notifyListeners();
  }

  Future<void> logout({Map<String, String> data}) async {
    loading = true;
    notifyListeners();
    await UserPreferences().saveToken(null);
    await UserPreferences().saveLogin(null);
    isLoggedIn = false;
    loading = false;
    notifyListeners();
  }
}
