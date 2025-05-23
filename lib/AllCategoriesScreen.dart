import 'package:flutter/material.dart';
import 'FoodDetailsScreen.dart';

class AllCategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Pizza",
      "category": "Principal",
      "rating": 4,
      "image": 'assets/images/pizza.jpg',
      "description": "Une pizza savoureuse avec du fromage fondant et des légumes frais.",
      "ingredients": ["Pâte", "Fromage", "Tomates", "Poivrons", "Champignons"]
    },
    {
      "title": "Cheese Cake",
      "category": "Dessert",
      "rating": 4.5,
      "image": 'assets/images/cheesecake.jpg',
      "description": "Un cheesecake onctueux avec une base de biscuit croustillant.",
      "ingredients": ["Biscuit", "Fromage frais", "Sucre", "Vanille", "Œufs"]
    },
    {
      "title": "Salade César",
      "category": "Entrée",
      "rating": 4,
      "image": 'assets/images/salade.jpg',
      "description": "Salade croquante accompagnée de poulet grillé et de sauce césar.",
      "ingredients": ["Laitue", "Poulet", "Croûtons", "Parmesan", "Sauce César"]
    },
    {
      "title": "Bourek",
      "category": "Entrée",
      "rating": 5,
      "image": 'assets/images/bourek.jpg',
      "description": "Délicieux bourek farci de viande hachée et fromage, croustillant à souhait.",
      "ingredients": ["Feuilles de brick", "Viande hachée", "Oignons", "Fromage", "Œufs"]
    },
    {
      "title": "Jus d'orange",
      "category": "Boisson",
      "rating": 5,
      "image": 'assets/images/jus.jpg',
      "description": "Un jus d'orange frais, naturel et riche en vitamine C.",
      "ingredients": ["Oranges", "Sucre", "Eau"]
    },
    {
      "title": "Café",
      "category": "Boisson",
      "rating": 4.7,
      "image": 'assets/images/cafe.jpg',
      "description": "Un café chaud et fort, parfait pour commencer la journée.",
      "ingredients": ["Café moulu", "Eau", "Sucre"]
    },
  ];

  /// Choisit une couleur de bordure selon la catégorie et le nom du plat
  Color getBorderColor(String category, String title) {
    if (category == "Boisson") {
      if (title.toLowerCase().contains("jus")) {
        return Colors.blue; // Jus glacé
      } else if (title.toLowerCase().contains("café") || title.toLowerCase().contains("cafe")) {
        return Colors.brown; // Café chaud
      } else {
        return Colors.orange; // Boisson générique
      }
    }

    switch (category) {
      case "Principal":
        return Colors.red;
      case "Entrée":
        return Colors.green;
      case "Dessert":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

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
            const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hey Halal, Good Afternoon",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Categories",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("See All",
                      style: TextStyle(fontSize: 14, color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final borderColor =
                  getBorderColor(item["category"], item["title"]);

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
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: borderColor, width: 4),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6)),
                              child: Image.asset(
                                item["image"],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["title"],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(item["category"],
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16, color: Colors.orange),
                                    const SizedBox(width: 4),
                                    Text(item["rating"].toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
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
            ],
          ),
        ),
      ),
    );
  }
}
