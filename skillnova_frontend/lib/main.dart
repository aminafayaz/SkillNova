import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skillnova_frontend/authpage.dart';
import 'package:skillnova_frontend/explorepage.dart';
import 'package:skillnova_frontend/loginpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return Authpage();
  }
}