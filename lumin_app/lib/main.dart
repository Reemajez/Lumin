import 'package:flutter/material.dart';
import 'package:lumin_application/Screens/login.dart';
import 'package:lumin_application/Screens/splash/splash_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashPage(),

    );
  }
}
