import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tell_craft/features/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tell_craft/firebase/firebase_options.dart';

void main() {
  testWidgets('Login page UI test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Build our LoginPage widget.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find text fields.
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Find the login button.
    expect(find.text('Entrar'), findsOneWidget);

    // Verify that status text is empty initially.
    expect(find.text(''), findsOneWidget);
  });

  testWidgets('Login page validation test', (WidgetTester tester) async {
    // Build our LoginPage widget.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Tap the login button without entering anything.
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    // Verify that both text fields show validation errors.
    expect(find.text('Email está vazio'), findsOneWidget);
    expect(find.text('Senha está vazia'), findsOneWidget);
  });

  testWidgets('Login page blocked account test', (WidgetTester tester) async {
    // Build our LoginPage widget.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Enter invalid credentials three times.
    for (int i = 0; i < 3; i++) {
      await tester.enterText(find.byType(TextFormField).first, 'invalid_email');
      await tester.enterText(
          find.byType(TextFormField).last, 'invalid_password');
      await tester.tap(find.text('Entrar'));
      await tester.pump();
    }

    // Verify that account is blocked.
    expect(find.text('Conta bloqueada. Tente novamente mais tarde.'),
        findsOneWidget);

    // Wait for 30 seconds (block timer duration).
    await tester.pump(const Duration(seconds: 30));

    // Verify that account is unblocked.
    expect(find.text('Conta bloqueada. Tente novamente mais tarde.'),
        findsNothing);
  });
}
