import 'package:flutter/material.dart';
import 'commentaire_page.dart'; // <-- Assure-toi que le chemin est correct

class FoodDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final double rating;
  final String image;
  final String description;
  final List<String> ingredients;

  const FoodDetailsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.rating,
    required this.image,
    required this.description,
    required this.ingredients,
  });

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 40),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                Text(" ${widget.rating} (10 Reviews)"),
                const SizedBox(width: 10),
                const Icon(Icons.access_time, color: Colors.grey, size: 16),
                const Text(" 40 min "),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(widget.category,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "INGREDIENTS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...widget.ingredients.map((ingredient) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Text(ingredient),
                ],
              ),
            )),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            AnimatedCrossFade(
              firstChild: Text(
                widget.description.length > 100
                    ? widget.description.substring(0, 100) + "..."
                    : widget.description,
                style: const TextStyle(color: Colors.grey),
              ),
              secondChild: Text(
                widget.description,
                style: const TextStyle(color: Colors.grey),
              ),
              crossFadeState: _isDescriptionExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              child: Text(
                _isDescriptionExpanded ? "Show Less" : "Show More",
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Bouton "Add to Cart"
            ElevatedButton.icon(
              onPressed: () {
                // Action personnalisée
              },
              icon: const Icon(Icons.add),
              label: const Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Bouton "Voir les commentaires"
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommentairePage()),
                );
              },
              icon: const Icon(Icons.comment),
              label: const Text("Voir les commentaires"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
