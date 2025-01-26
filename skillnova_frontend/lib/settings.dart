import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillnova_frontend/loginpage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  signUserOut();
                  
                  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>Loginpage()),
    );
                },
                icon: Icon(Icons.logout_rounded))
          ],
        ),
      ),
    );
  }
}
