import 'package:flutter/material.dart';
import 'package:tell_craft/features/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tell_craft/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tell_Craft',
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
