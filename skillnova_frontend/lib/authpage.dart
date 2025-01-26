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
                creditPoints: 0, 
                updateCreditPoints: (int points) {}, 
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