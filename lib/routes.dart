import 'package:api_practica/screens/home_screen.dart';
import 'package:api_practica/screens/login_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
  };
}
