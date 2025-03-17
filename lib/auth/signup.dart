import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';
import '../main.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> addUser() async {
    String usernameText = username.text;
    String emailText = email.text;
    String passwordText = password.text;

    try {
      // Create the user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText,
        password: passwordText,
      );

      // Add the user to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'username': usernameText,
        'email': emailText,
        'password': passwordText,
        'role': 'user',
      });

      // Navigate to the DataScreen after successful sign-up
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DataScreen()),
      );
    } catch (error) {
      // Handle sign-up errors here
      print("Error signing up: $error");
      // You can show an error message to the user using a snackbar or any other method
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
            Lottie.network('https://lottie.host/917987e4-029e-44b2-9096-6afa46e0f56d/a6xOvMZTci.json'),


            Container(height: 0),

            Container(height: 0),
            const Text(
              'Username',
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
            CustomTextForm(hinttext: "Enter Your username", mycontroller: username),
            Container(height: 10),
            const Text(
              'Email',
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
            const  Text(
              'Password',
              style: TextStyle(

                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'B',
                letterSpacing: 2,
                color: Colors.black, // Make the text slightly transparent
                wordSpacing: 1,

              ),
            ),
            Container(height: 2),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                // Your UI components
              ],
            ),
            CustomButtonAuth(title: "SignUp", onPressed: addUser),
            Container(height: 20),

            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(style: TextStyle(fontFamily: 'C'),
                    text: "Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(color: Colors.orange,fontFamily: 'B', fontWeight: FontWeight.bold)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}


