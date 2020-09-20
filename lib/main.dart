import 'package:flutter/material.dart';
import 'package:pokedex/Screens/pokemon_detail.dart';
import 'package:provider/provider.dart';

import 'homeNavigator.dart';

import './providers/authprovider.dart';
import './providers/pokeProvider.dart';

void main() {
  runApp(PokeApp());
}

// ignore: must_be_immutable
class PokeApp extends StatelessWidget {
  dynamic _pokedata;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PokeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'PokeApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.black),
          accentColor: Colors.black,
          backgroundColor: Colors.white,
          dividerColor: Colors.grey[400],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                headline2: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                headline3: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                button: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: HomeNavigatorPage(),
        routes: {
          PokemonDetail.routeName: (ctx) => PokemonDetail(data: _pokedata),
        },
      ),
    );
  }
}
