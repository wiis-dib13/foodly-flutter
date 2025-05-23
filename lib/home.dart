import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🎨 Décor en haut à gauche
          Positioned(
            top: 0,
            left: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                color: Colors.green[300],
              ),
            ),
          ),

          // 🎨 Décor en bas à droite
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(reverse: true),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                color: Colors.green[200],
              ),
            ),
          ),

          // 🚀 Logo cliquable au centre
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Bienvenue sur Foodly',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cliquez sur le logo pour commencer',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🎨 Définition du WaveClipper (simple vague)
class WaveClipper extends CustomClipper<Path> {
  final bool reverse;
  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    var path = Path();
    if (reverse) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.5, 80, size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.lineTo(0, size.height);
      path.quadraticBezierTo(size.width * 0.5, size.height - 80, size.width, size.height);
      path.lineTo(size.width, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
