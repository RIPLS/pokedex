import 'package:flutter/material.dart';
import './Screens/login.dart';
import './Screens/pokemon.dart';

import 'Screens/welcome.dart';

import './utils/route.dart';

import './widgets/modals/alertDialog.dart';

class HomeNavigatorPage extends StatefulWidget {
  HomeNavigatorPage({Key key}) : super(key: key);

  @override
  _HomeNavigatorPageState createState() => _HomeNavigatorPageState();
}

class _HomeNavigatorPageState extends State<HomeNavigatorPage> {
  String title;
  Widget screen;
  RoutePage route;
  Function _floatingFunction;
  Icon _floatingIcon;

  @override
  void initState() {
    title = "PokeApp";
    route = RoutePage.Welcome;
    screen = WelcomePage(routeSelection: routeSelection);
    super.initState();
  }

  void routeSelection(RoutePage _route) {
    route = _route;
    switch (_route) {
      case RoutePage.Welcome:
        screen = WelcomePage(routeSelection: routeSelection);
        break;
      case RoutePage.Login:
        _floatingIcon = Icon(Icons.arrow_back);
        _floatingFunction = () => routeSelection(RoutePage.Welcome);
        screen = LoginScreen(setAuth: routeSelection);
        break;
      case RoutePage.Pokemon:
        _floatingIcon = Icon(Icons.exit_to_app);
        _floatingFunction = () => logout();
        screen = PokemonScreen();
        break;
      default:
    }
    setState(() {});
  }

  void logout() async {
    await showDialog(
      context: context,
      builder: (ctx) =>
          ConfirmModal(ctx, () => routeSelection(RoutePage.Login)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: screen,
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
}
