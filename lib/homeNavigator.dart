import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Screens/login.dart';
import './Screens/pokemon.dart';
import './Screens/welcome.dart';

import './providers/authprovider.dart';
import './data/auth.dart';
import './utils/route.dart';

import './widgets/modals/alertDialog.dart';

class HomeNavigatorPage extends StatefulWidget {
  HomeNavigatorPage({Key key}) : super(key: key);

  @override
  _HomeNavigatorPageState createState() => _HomeNavigatorPageState();
}

class _HomeNavigatorPageState extends State<HomeNavigatorPage>
    implements AuthStateListener {
  String title;
  Widget screen;
  RoutePage route;
  Function _floatingFunction;
  Icon _floatingIcon;

  AuthStateProvider _authStateProvider;
  AuthState initAuth;

  _HomeNavigatorPageState() {
    _authStateProvider = new AuthStateProvider();
  }

  @override
  void initState() {
    title = "PokeApp";
    route = RoutePage.Welcome;
    screen = WelcomePage(routeSelection: routeSelection);
    _authStateProvider.subscribe(this);
    super.initState();
  }

  @override
  void onAuthStateChanged(AuthState state) {
    initAuth = state;
    setState(() {});
  }

  Widget _screen(AuthState _state) {
    switch (_state) {
      case AuthState.LOGGED_IN:
        routeSelection(RoutePage.Pokemon);
        return screen;
      case AuthState.LOGGED_OUT:
        routeSelection(route);
        return screen;
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  void routeSelection(RoutePage _route) {
    route = _route;
    switch (_route) {
      case RoutePage.Welcome:
        screen = WelcomePage(routeSelection: routeSelection);
        break;
      case RoutePage.Login:
        _floatingIcon = Icon(Icons.arrow_back);
        _floatingFunction = () {
          routeSelection(RoutePage.Welcome);
          setState(() {});
        };
        screen = LoginScreen(setAuth: login);
        setState(() {});
        break;
      case RoutePage.Pokemon:
        _floatingIcon = Icon(Icons.exit_to_app);
        _floatingFunction = () => logout();
        screen = PokemonScreen();
        break;
      default:
    }
  }

  void login(String user, String password) async {
    Provider.of<AuthProvider>(context, listen: false).login(user, password);
  }

  void logout() async {
    await showDialog(
      context: context,
      builder: (ctx) => ConfirmModal(ctx, () async {
        route = RoutePage.Login;
        Provider.of<AuthProvider>(context, listen: false).logout();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _screen(initAuth),
      floatingActionButton: route == RoutePage.Welcome
          ? null
          : FloatingActionButton(
              onPressed: _floatingFunction,
              tooltip: 'Increment',
              child: _floatingIcon,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  @protected
  @mustCallSuper
  void dispose() {
    _authStateProvider.unsubscribe(this);
    super.dispose();
  }
}
