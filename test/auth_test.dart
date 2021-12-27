import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icovid_app/icovid.dart';
import 'package:mockito/mockito.dart';


void main() {
  testWidgets('Test auth hyperlinks', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ICovid());

    expect(find.text('Login'), findsWidgets);

    await tester.tap(find.text('I have yet to register'));
    await tester.pumpAndSettle();

    expect(find.text('Register'), findsWidgets);

    await tester.tap(find.text('I have an account already'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
  });
}