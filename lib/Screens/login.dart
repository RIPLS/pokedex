import 'package:flutter/material.dart';
import 'package:pokeapp/widgets/loginCard.dart';
import 'package:pokeapp/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  final Function setAuth;
  LoginScreen({Key key, @required this.setAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppLogo(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Login / Sign Up",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: LoginCard(setAuth),
            ),
          ],
        ),
      ),
    );
  }
}
