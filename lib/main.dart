import 'package:flutter/material.dart';
import 'home.dart';
import 'onboarding_screen.dart';
import 'login.dart';
// Import de l'écran onboarding
// Import de la deuxième page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(), // Lancer sur OnboardingScreen
    );
  }
}
