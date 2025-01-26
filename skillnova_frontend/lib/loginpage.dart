import 'package:flutter/material.dart';
import 'package:skillnova_frontend/authpage.dart';
import 'package:skillnova_frontend/components/MyButton.dart';
import 'package:skillnova_frontend/components/MyTextField.dart';
import'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  // Text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Sign user in method
  void signUserIn() async {

    showDialog(context: context, builder:(context)
    {
      return const Center(child: CircularProgressIndicator(),);
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/navigation');
    }on FirebaseAuthException catch (e){
      Navigator.pop(context);
      if (e.code == 'user-not-found'){
        wrongEmailMessage();
      }else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }
  }


  void wrongEmailMessage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Incorrect Email'),
      );
    });
  }
  void wrongPasswordMessage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Incorrect Password'),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
            
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
            
                const SizedBox(height: 50),
            
                // Welcome back message
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
            
                // Username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
            
                // Password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
            
                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
            
                // Sign in button
                MyButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
            
                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
            
                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
