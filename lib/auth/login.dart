import 'package:app_iot/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';
import 'signup.dart'; // Import the SignUp screen if not already imported
 // Import the HomePage screen if not already imported

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // If sign in successful, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DataScreen()),
      );
    } catch (e) {
      // Handle sign-in errors
      print("Error signing in: $e");
      // Show error dialog or snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
               Color(0xFF800080), // Couleur primaire violet
               Color(0xFF6A0DAD),
              // Couleur d'accentuation avec légère transparence
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.network('https://lottie.host/7b61c89e-13df-432e-bd6f-98a38c38c442/hKKp22GBQv.json'),
                Container(height: 0),

                Container(height: 0),
                const Text(

                  "Email",
                  style: TextStyle(

                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'B',
                    letterSpacing: 2,
                    color: Colors.black, // Make the text slightly transparent
                    wordSpacing: 1,

                  ),
                ),
                Container(height: 10),
                CustomTextForm(hinttext: "Enter Your Email", mycontroller: email),
                Container(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(

                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'B',
                    letterSpacing: 2,
                    color: Colors.black, // Make the text slightly transparent
                    wordSpacing: 1,

                  ),
                ),
                Container(height: 10),
                CustomTextForm(hinttext: "Enter Your Password", mycontroller: password),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontFamily: 'D',
                      fontSize: 14,

                    ),
                  ),
                ),
              ],
            ),
            CustomButtonAuth(title: "Login", onPressed: signIn),
            Container(height: 20),

            Container(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                            fontFamily: 'C'
                        ),

                        text: "Don't Have An Account ? ",
                      ),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
