import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // save
  saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  saveLogin(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', value);
  }

  // get
  getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('loggedin');
    return logged;
  }
}
