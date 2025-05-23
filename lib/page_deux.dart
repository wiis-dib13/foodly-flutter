import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'page_troi.dart';

class PageDeux extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/pho2.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'All organized',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            Text(
              'Never be confused on what to cook ever again, plan your entire week.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),

            // 📌 Indicateurs de progression
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: index == 1 ? 10 : 8, // Page active = plus grand
                  height: index == 1 ? 10 : 8,
                  decoration: BoxDecoration(
                    color: index == 1 ? Colors.orange : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 30),

            // 📌 Bouton Next
            ElevatedButton(
              onPressed: () {
                // Remplace `NextPage()` par la page suivante
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageTroi()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'NEXT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 10),

            // 📌 Bouton Skip
            TextButton(
              onPressed: () {
                // Aller directement à l'écran principal (ex: HomeScreen)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
