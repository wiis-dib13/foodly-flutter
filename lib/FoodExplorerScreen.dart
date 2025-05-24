import 'package:flutter/material.dart';
import 'AllCategoriesScreen.dart';
import 'FoodDetailsScreen.dart';
import 'edit_profile.dart';
import 'calendar_page.dart';

class FoodExplorerScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Pizza",
      "category": "Principal",
      "rating": 4,
      "image": 'assets/pizza.png',
      "description": "Une pizza savoureuse avec du fromage fondant et des légumes frais.",
      "ingredients": ["Pâte", "Fromage", "Tomates", "Poivrons", "Champignons"]
    },
    {
      "title": "Cheese Cake",
      "category": "Dessert",
      "rating": 4.5,
      "image": 'assets/cake.jpg',
      "description": "Un cheesecake onctueux avec une base de biscuit croustillant.",
      "ingredients": ["Biscuit", "Fromage frais", "Sucre", "Vanille", "Œufs"]
    },
    {
      "title": "Salade César",
      "category": "Entrée",
      "rating": 4,
      "image": 'assets/salade.jpg',
      "description": "Salade croquante accompagnée de poulet grillé et de sauce césar.",
      "ingredients": ["Laitue", "Poulet", "Croûtons", "Parmesan", "Sauce César"]
    },
    {
      "title": "Bourek",
      "category": "Entrée",
      "rating": 5,
      "image": 'assets/bourak.jpg',
      "description": "Délicieux bourek farci de viande hachée et fromage, croustillant à souhait.",
      "ingredients": ["Feuilles de brick", "Viande hachée", "Oignons", "Fromage", "Œufs"]
    },
    {
      "title": "Jus d'orange",
      "category": "Boisson",
      "rating": 5,
      "image": 'assets/jus.jpg',
      "description": "Un jus d'orange frais, naturel et riche en vitamine C.",
      "ingredients": ["Oranges", "Sucre", "Eau"]
    },
    {
      "title": "Café",
      "category": "Boisson",
      "rating": 4.7,
      "image": 'assets/cafe.jpg',
      "description": "Un café chaud et fort, parfait pour commencer la journée.",
      "ingredients": ["Café moulu", "Eau", "Sucre"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset("assets/logo.png", height: 50),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hey Halal, Good Afternoon",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search dishes, restaurants",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton(context, "All", Icons.list, AllCategoriesScreen()),
                  _buildCategoryButton(context, "Entrée", Icons.fastfood, null),
                  _buildCategoryButton(context, "Dessert", Icons.cake, null),
                  _buildCategoryButton(context, "Principal", Icons.local_pizza, null),
                  _buildCategoryButton(context, "Boisson", Icons.local_drink, null),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Dishes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailsScreen(
                            title: item["title"],
                            category: item["category"],
                            rating: item["rating"].toDouble(),
                            image: item["image"],
                            description: item["description"],
                            ingredients: List<String>.from(item["ingredients"]),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              item["image"],
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item["category"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 16, color: Colors.orange),
                                    const SizedBox(width: 4),
                                    Text(
                                      item["rating"].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String categoryName,
    IconData icon,
    Widget? page,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          } else {
            print("Category clicked: $categoryName");
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              categoryName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
