import 'package:flutter/widgets.dart';
import 'package:lomaysowda/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  bool _user;
  UserProvider({@required user}) {
    this._user = user;
  }

  Future<void> login({Map<String, String> data}) async {
    this.loading = true;
    notifyListeners();
    bool res = await LoginAPI.loginService(data: data);
    this._user = res;
    this.loading = false;
    notifyListeners();
  }

  Future<void> logout({Map<String, String> data}) async {
    this.loading = true;
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    this.loading = false;
    this._user = false;
    notifyListeners();
  }

  bool get getUser => this._user ?? false;
}
