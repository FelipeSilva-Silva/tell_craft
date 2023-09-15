import 'package:flutter/material.dart';
import 'package:tell_craft/features/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tell_craft/firebase/firebase_options.dart';
import 'dart:io';

// usar só em desenvolvimento esse httpOverrides => trocar para conseguir o certificado em produção
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
