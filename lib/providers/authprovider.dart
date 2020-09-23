import 'package:flutter/widgets.dart';

import '../data/database_helper.dart';
import '../utils/UserSession.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT, LOADING }

class AuthProvider with ChangeNotifier {
  AuthState currentState = AuthState.LOADING;
  String token;
  DatabaseHelper db;

  AuthProvider({DatabaseHelper dbHelper}) {
    if (dbHelper != null) {
      db = dbHelper;
    } else {
      db = new DatabaseHelper();
    }
    initState();
  }

  void initState() async {
    var isLoggedIn = await db.isLoggedIn();
    if (isLoggedIn != null) {
      currentState = AuthState.LOGGED_IN;
      token = isLoggedIn;
      notifyListeners();
    } else {
      currentState = AuthState.LOGGED_OUT;
      token = null;
      notifyListeners();
    }
  }

  void login(String username, String password) async {
    onLoginSuccess(username, password);
  }

  void onLoginError(String errorTxt) {}

  void onLoginSuccess(String username, String password) async {
    UserSession user = new UserSession(username, password);
    await db.saveUser(user);
    currentState = AuthState.LOGGED_IN;
    notifyListeners();
  }

  Future<void> logout() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
    currentState = AuthState.LOGGED_OUT;
    notifyListeners();
  }
}
