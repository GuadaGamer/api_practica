import 'package:api_practica/routes.dart';
import 'package:api_practica/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const APIAPP();
  }
}

class APIAPP extends StatelessWidget {
  const APIAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: getApplicationRoutes(),
      home: OnboardingScreen(),
    );
  }
}
