import 'package:flutter/material.dart';
import 'package:tell_craft/features/login/login_page.dart';

void main() {
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
