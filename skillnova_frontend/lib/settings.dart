import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillnova_frontend/authpage.dart';
import 'package:skillnova_frontend/loginpage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logoutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logoutUser(context),
          child: Text('Log Out'),
        ),
      ),
    );
  }
}