import 'package:flutter/widgets.dart';

import '../data/database_helper.dart';
import '../data/auth.dart';
import '../utils/UserSession.dart';

class AuthProvider with ChangeNotifier {
  void login(String username, String password) async {
    onLoginSuccess(username, password);
  }

  void onLoginError(String errorTxt) {}

  void onLoginSuccess(String username, String password) async {
    UserSession user = new UserSession(username, password);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    AuthStateProvider.token = password;
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

  Future<void> logout() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_OUT);
  }
}
