import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pokeapp/main.dart';

void main() {
  testWidgets('Welcome Page to Login Routing test',
      (WidgetTester tester) async {
    await tester.pumpWidget(PokeApp());

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
    // Build our app and trigger a frame.
    await tester.pumpWidget(PokeApp());

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
    // Build our app and trigger a frame.
    await tester.pumpWidget(PokeApp());

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
