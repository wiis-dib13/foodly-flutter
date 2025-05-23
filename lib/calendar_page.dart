import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'personalrecipe.dart';


// ignore: unused_import
import 'dart:typed_data';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  final List<DateTime> days = List.generate(
    60,
    (i) => DateTime.now().subtract(Duration(days: 30 - i)),
  );

  PageController _pageController = PageController(viewportFraction: 0.2, initialPage: 30);
  int currentPage = 30;

  List<String> meals = ['Breakfast', 'Lunch', 'Dinner'];
  Map<String, bool> isExpanded = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
  };

  Map<String, Map<DateTime, List<Map<String, dynamic>>>> mealsData = {
    'Breakfast': {},
    'Lunch': {},
    'Dinner': {},
  };

  @override
  void initState() {
    super.initState();
    selectedDate = days[currentPage];
    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (newPage != currentPage) {
        setState(() {
          currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double getOpacity(int index) {
    int diff = (index - currentPage).abs();
    if (diff == 0) return 1.0;
    if (diff == 1) return 0.7;
    return 0.4;
  }

  double getFontSize(int index) {
    return index == currentPage ? 28 : 20;
  }

  FontWeight getFontWeight(int index) {
    return index == currentPage ? FontWeight.bold : FontWeight.normal;
  }

  void _navigateToPersonalRecipe(String mealType) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalRecipePage(mealType: mealType, date: selectedDate),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final mealList = mealsData[result['mealType']]!;
      final day = result['date'];

      if (!mealList.containsKey(day)) {
        mealList[day] = [];
      }

      mealList[day]!.add({
        'name': result['name'],
        'image': result['image'],
      });

      setState(() {});
    }
  }

  void _showAddMealOptions(String meal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Meal"),
        content: Text("What would you like to do?"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.home, color: Colors.green),
            label: Text("Go to Main Page"),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToPersonalRecipe(meal);
            },
            icon: Icon(Icons.restaurant_menu, color: Colors.green),
            label: Text("Upload Personal Recipe"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.1),
            child: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.green),
          ),
        ),
        title: Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'RobotoMono',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/logo.png', height: 30),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 110,
            child: PageView.builder(
              controller: _pageController,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isSelected = day.day == selectedDate.day && day.month == selectedDate.month && day.year == selectedDate.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    child: Opacity(
                      opacity: getOpacity(index),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isSelected)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  width: 60,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green.withOpacity(0.3), width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(day),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.green : Colors.black54,
                                  fontFamily: 'RobotoMono',
                                ),
                              ),
                              SizedBox(height: 4),
                              AnimatedDefaultTextStyle(
                                duration: Duration(milliseconds: 200),
                                style: TextStyle(
                                  fontSize: getFontSize(index),
                                  fontWeight: getFontWeight(index),
                                  color: isSelected ? Colors.green : Colors.black,
                                  fontFamily: 'RobotoMono',
                                ),
                                child: Text('${day.day}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: meals.map((meal) {
                final mealItems = mealsData[meal]?[selectedDate] ?? [];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(meal),
                        trailing: Icon(isExpanded[meal]! ? Icons.expand_less : Icons.expand_more),
                        onTap: () {
                          setState(() {
                            isExpanded[meal] = !isExpanded[meal]!;
                          });
                        },
                      ),
                      if (isExpanded[meal]!)
                        Column(
                          children: [
                            ...mealItems.map((item) => Column(
                                  children: [
                                    Divider(thickness: 0.5, height: 1),
                                    ListTile(
                                      leading: item['image'] != null
                                          ? Image.memory(item['image'], width: 40, height: 40, fit: BoxFit.cover)
                                          : Icon(Icons.fastfood),
                                      title: Text(item['name']),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: ElevatedButton.icon(
                                onPressed: () => _showAddMealOptions(meal),
                                icon: Icon(Icons.add),
                                label: Text('Add Meal'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
