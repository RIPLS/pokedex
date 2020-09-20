import '../data/database_helper.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT }

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

// A naive implementation of Observer/Subscriber Pattern. Will do for now.
class AuthStateProvider {
  static final AuthStateProvider _instance = new AuthStateProvider.internal();
  static String token = "";
  static AuthState currentState = AuthState.LOGGED_OUT;

  List<AuthStateListener> _subscribers;
  DatabaseHelper db;

  factory AuthStateProvider() => _instance;

  AuthStateProvider.internal() {
    _subscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async {
    db = new DatabaseHelper();
    var isLoggedIn = await db.isLoggedIn();
    if (isLoggedIn != null) {
      currentState = AuthState.LOGGED_IN;
      notify(currentState);
      token = isLoggedIn;
    } else
      currentState = AuthState.LOGGED_OUT;
    notify(AuthState.LOGGED_OUT);
  }

  Future<void> onTokenNotValid() async {
    //setState(() => _isLoading = false);
    await db.deleteUsers();
    currentState = AuthState.LOGGED_OUT;
    notify(AuthState.LOGGED_OUT);
  }

  void subscribe(AuthStateListener listener) {
    _subscribers.add(listener);
    notifyJustOne(listener, currentState);
  }

  void unsubscribe(AuthStateListener listener) {
    _subscribers.remove(listener);
  }

  void dispose(AuthStateListener listener) {
    for (var l in _subscribers) {
      if (l == listener) _subscribers.remove(l);
    }
  }

  void notify(AuthState state) {
    _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state));
  }

  void notifyJustOne(AuthStateListener listener, AuthState state) {
    listener.onAuthStateChanged(state);
  }
}
