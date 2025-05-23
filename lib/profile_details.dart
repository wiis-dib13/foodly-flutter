import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mon_projet/edit_profile.dart';
import 'package:mon_projet/recently_used.dart';
import 'personal_dishes.dart';
import 'recently_used.dart';

class ProfileDetailsPage extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;
  final String motivation;
  final File? profileImage;

  const ProfileDetailsPage({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.motivation,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with back and edit
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfilePage(
                            initialName: fullName,
                            initialEmail: email,
                            initialPhone: phone,
                            initialMotivation: motivation,
                            initialImage: profileImage,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "EDIT",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Profile Image and Name Section
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : AssetImage("assets/logo.png") as ImageProvider,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            motivation,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Info Cards
              infoCard(Icons.person, "FULL NAME", fullName),
              infoCard(Icons.email, "EMAIL", email),
              infoCard(Icons.phone, "PHONE NUMBER", phone),
              SizedBox(height: 20),
              // Action Buttons
              actionButton(Icons.history, "HISTORY", () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RecentlyUsedScreen()),
                      );
              }),
              actionButton(Icons.warning_amber, "ALLERGIES", () {}),
              actionButton(Icons.restaurant_menu, "PERSONAL DISHES", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalDishesScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                SizedBox(height: 4),
                Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            SizedBox(width: 12),
            Expanded(
              child: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
