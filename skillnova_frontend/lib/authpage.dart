import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillnova_frontend/explorepage.dart';
import 'package:skillnova_frontend/loginpage.dart';
import 'package:skillnova_frontend/settings.dart';
import 'package:skillnova_frontend/skillpage.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body:StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ExplorePage(
                creditPoints: 0, // Provide appropriate value
                updateCreditPoints: (int points) {}, // Provide appropriate function
              );
            }
            else{
              return Loginpage();
            }
          },
          )
      ),
    );
  }}