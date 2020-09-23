import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokeapp/Screens/pokemon_detail.dart';
import 'package:pokeapp/data/database_helper.dart';
import 'package:pokeapp/homeNavigator.dart';

import 'package:pokeapp/providers/authprovider.dart';
import 'package:pokeapp/providers/pokeProvider.dart';
import 'package:provider/provider.dart';

class MockedDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  dynamic _pokedata;

  var mockedDatabaseHelper = MockedDatabaseHelper();

  var pokeApp = MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(dbHelper: mockedDatabaseHelper)),
      ChangeNotifierProvider<PokeProvider>(create: (_) => PokeProvider()),
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
  testWidgets('Welcome Page to Login Routing test',
      (WidgetTester tester) async {
    when(mockedDatabaseHelper.isLoggedIn()).thenAnswer((_) async => null);
    await tester.pumpWidget(pokeApp);
    await tester.pump(Duration(seconds: 1));

    // await tester.tap(find.byIcon(Icons.exit_to_app));
    // await tester.pump(Duration(seconds: 1));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pump(Duration(seconds: 1));

    expect(find.text('User'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Login Success Integration Test', (WidgetTester tester) async {
    when(mockedDatabaseHelper.isLoggedIn()).thenAnswer((_) async => null);
    await tester.pumpWidget(pokeApp);
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pump(Duration(seconds: 1));

    expect(find.text('User'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'user');
    await tester.enterText(find.byType(TextFormField).last, 'pass');

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Pokemon List'), findsOneWidget);
  });

  testWidgets('Login Pass Missing Integration Test',
      (WidgetTester tester) async {
    when(mockedDatabaseHelper.isLoggedIn()).thenAnswer((_) async => null);
    await tester.pumpWidget(pokeApp);
    await tester.pump(Duration(seconds: 1));

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pump(Duration(seconds: 1));

    expect(find.text('User'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Tap the Login button and trigger a frame.
    await tester.tap(find.text('Login'));
    await tester.pump(Duration(seconds: 1));

    expect(find.text('Please enter User'), findsOneWidget);
    expect(find.text('Please enter Password'), findsOneWidget);
    expect(find.text('Pokemon List'), findsNothing);
  });
}
