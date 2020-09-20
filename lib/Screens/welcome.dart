import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/logo.dart';
import '../utils/route.dart';

class WelcomePage extends StatelessWidget {
  final Function routeSelection;
  WelcomePage({Key key, @required this.routeSelection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppLogo(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                "Welcome to PokeApp",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Text(
              'Here you will find the neccessary information about your favorite Pokemons.',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ButtonWidget(
                  buttonColor: Colors.indigo[900],
                  buttonFunction: () => this.routeSelection(RoutePage.Login),
                  buttonText: "Login"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ButtonWidget(
                  buttonColor: Colors.grey,
                  buttonFunction: () {},
                  buttonText: "About Us"),
            ),
          ],
        ),
      ),
    );
  }
}
