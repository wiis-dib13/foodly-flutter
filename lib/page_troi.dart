import 'package:flutter/material.dart';
import 'page_deux.dart';
import 'page_quatre.dart';

class PageTroi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 162, 162),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📌 Image arrondie
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/pho3.png', // Assure-toi que l'image existe
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 📌 Titre
            const Text(
              'Not sure where to start?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // 📌 Description
            const Text(
              'Check our most rated plates and those recommended by chefs.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // 📌 Indicateurs de progression (3e point actif)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: index == 2 ? 10 : 8, // Le 3e point est actif
                  height: index == 2 ? 10 : 8,
                  decoration: BoxDecoration(
                    color: index == 2 ? Colors.orange : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // 📌 Bouton Next
            ElevatedButton(
              onPressed: () {
                // Remplace `NextPage()` par la page suivante
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageQuatre()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            // 📌 Bouton Skip
            TextButton(
              onPressed: () {
                // Aller directement à l'écran principal (ex: HomeScreen)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageDeux()),
                );
              },
              child: const Text(
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
