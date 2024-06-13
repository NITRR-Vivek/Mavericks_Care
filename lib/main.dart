// lib/main.dart

import 'package:flutter/material.dart';
import 'package:mavericscare/presentation/home_screen.dart';
import 'package:mavericscare/presentation/login_page/login_page.dart';
import 'package:mavericscare/presentation/login_page/otp_screen.dart';
import 'package:mavericscare/presentation/splash_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.accentColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScreen(),
        '/login': (context) => const LoginPage(),
        '/otp': (context) => const OTPScreen(phone: '', country: ''),
      },
    );
  }
}
