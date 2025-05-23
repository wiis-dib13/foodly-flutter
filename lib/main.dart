import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'personal_dishes.dart';
import 'recently_used.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfileApp(), 
    );
  }
}
