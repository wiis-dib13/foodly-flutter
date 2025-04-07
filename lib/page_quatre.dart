import 'package:flutter/material.dart';
import 'page_cinq.dart';
import 'page_troi.dart';

class PageQuatre extends StatelessWidget {
  const PageQuatre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📌 Image arrondie
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/pho4.png', // Vérifie bien le chemin et `pubspec.yaml`
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 📌 Titre
            const Text(
              'try something new',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // 📌 Description
            const Text(
              'Whenever feeling adventurous, try our randomizer and cook with the flow.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // 📌 Indicateurs de progression (4e point actif)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: index == 3 ? 10 : 8, // Le 4e point est actif
                  height: index == 3 ? 10 : 8,
                  decoration: BoxDecoration(
                    color: index == 3 ? Colors.orange : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // 📌 Bouton Next
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageCinq()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PageTroi()),
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
