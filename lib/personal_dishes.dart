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
      title: 'Mes Plats Personnels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const PersonalDishesScreen(),
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

class PersonalDishesScreen extends StatefulWidget {
  const PersonalDishesScreen({Key? key}) : super(key: key);

  @override
  _PersonalDishesScreenState createState() => _PersonalDishesScreenState();
}

class _PersonalDishesScreenState extends State<PersonalDishesScreen> {
  final List<Dish> dishes = [
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
          'Personal dishes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'EDIT',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return DishCard(
                  dish: dish,
                  onFavoriteToggle: () {
                    setState(() {
                      dish.isFavorite = !dish.isFavorite;
                    });
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: FloatingActionButton(
              onPressed: () {
                _showAddDishDialog();
              },
              backgroundColor: Colors.white,
              elevation: 2,
              child: const Icon(Icons.add, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDishDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un plat'),
          content: const Text('Choisissez le type de plat que vous voulez ajouter'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAddDishForm(DishType.entree);
              },
              child: const Text('Entrée', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAddDishForm(DishType.main);
              },
              child: const Text('Plat', style: TextStyle(color: Colors.orange)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showAddDishForm(DishType.dessert);
              },
              child: const Text('Dessert', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void _showAddDishForm(DishType type) {
    String name = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un ${type == DishType.entree ? 'entrée' : type == DishType.main ? 'plat' : 'dessert'}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nom du plat'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    dishes.add(
                      Dish(
                        name: name,
                        description: description,
                        imageUrl: 'assets/images/default.jpg',
                        type: type,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}

class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onFavoriteToggle;

  const DishCard({
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
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
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dish.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              bottom: 8,
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
      ),
    );
  }
}