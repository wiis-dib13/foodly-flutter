import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Redirection automatique après 3 secondes
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/onboarding'); // Redirection vers l'onboarding
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 📌 Décor en haut à gauche
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'lib/assets/top_decor.png', // Ajoute l'image décorative ici
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          // 📌 Décor en bas à droite
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'lib/assets/bottom_decor.png', // Ajoute l'image décorative ici
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          // 📌 Contenu principal (logo et texte)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Remplace par ton logo
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 10),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
