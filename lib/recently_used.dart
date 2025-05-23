import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mes Plats Récents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const RecentlyUsedScreen(),
    );
  }
}

class Dish {
  final String name;
  final String description;
  final String imageUrl;
  final DishType type;
  bool isFavorite;

  Dish({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.isFavorite = false,
  });
}

enum DishType { entree, main, dessert }

class RecentlyUsedScreen extends StatefulWidget {
  const RecentlyUsedScreen({Key? key}) : super(key: key);

  @override
  _RecentlyUsedScreenState createState() => _RecentlyUsedScreenState();
}

class _RecentlyUsedScreenState extends State<RecentlyUsedScreen> {
  final List<Dish> recentlyUsedDishes = [
    Dish(
      name: 'Fellel Medgoug',
      description: 'Fellel',
      imageUrl: 'assets/images/fellel.jpg',
      type: DishType.main,
    ),
    Dish(
      name: 'Tajin',
      description: 'Meat, Eggs, Vegetables',
      imageUrl: 'assets/images/tajin.jpg',
      type: DishType.main,
    ),
    Dish(
      name: 'Salade De Fruit',
      description: 'Yogurt, Fruits',
      imageUrl: 'assets/images/salade.jpg',
      type: DishType.dessert,
    ),
    Dish(
      name: 'Shawerma',
      description: 'Chicken, Method',
      imageUrl: 'assets/images/shawerma.jpg',
      type: DishType.entree,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
                Navigator.pop(context);
          },
        ),
        title: const Text(
          'Recently used',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: recentlyUsedDishes.length,
        itemBuilder: (context, index) {
          final dish = recentlyUsedDishes[index];
          return RecentDishCard(
            dish: dish,
            onFavoriteToggle: () {
              setState(() {
                dish.isFavorite = !dish.isFavorite;
              });
            },
          );
        },
      ),
    );
  }
}

class RecentDishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onFavoriteToggle;

  const RecentDishCard({
    Key? key,
    required this.dish,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    switch (dish.type) {
      case DishType.entree:
        buttonColor = Colors.green;
        break;
      case DishType.main:
        buttonColor = Colors.orange;
        break;
      case DishType.dessert:
        buttonColor = Colors.blue;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image de plat
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                dish.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.restaurant, size: 40, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          // Information du plat
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dish.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Bouton d'ajout
          Padding(
            padding: const EdgeInsets.all(12),
            child: FloatingActionButton.small(
              onPressed: onFavoriteToggle,
              backgroundColor: buttonColor,
              child: Icon(
                dish.isFavorite ? Icons.favorite : Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}