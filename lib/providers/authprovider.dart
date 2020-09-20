import 'package:flutter/widgets.dart';

import '../data/database_helper.dart';
import '../data/auth.dart';
import '../utils/UserSession.dart';

class AuthProvider with ChangeNotifier {
  bool auth = false;

  void login(String email, String password) async {
    onLoginSuccess(email, password);
  }

  void onLoginError(String errorTxt) {}

  void onLoginSuccess(String username, String password) async {
    UserSession user = new UserSession(username, password);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

// Future<ResponseDto<dynamic>> signin(
//     String username, String password, String name) async {
//   var body = {};
//   body['email'] = username;
//   body['password'] = password;
//   body['name'] = name;

// }

// Future<void> logout() async {
//   var db = new DatabaseHelper();
//   await db.deleteUsers();
//   var authStateProvider = new AuthStateProvider();
//   authStateProvider.notify(AuthState.LOGGED_OUT);
// }
}
