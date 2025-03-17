import 'package:app_iot/auth/AddUserScreen.dart';
import 'package:app_iot/auth/AdminScreen.dart';
import 'package:app_iot/auth/ChoiceScreen.dart';
import 'package:app_iot/auth/ModifyUserScreen.dart';
import 'package:app_iot/auth/signup.dart';
import 'package:app_iot/auth/signupAdmin.dart';
import 'package:app_iot/homepage.dart';
import 'package:app_iot/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginState();
}

class _LoginState extends State<LoginAdmin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B132B), // Couleur primaire bleu profond
              Color(0xFF00BCD4),
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
              Container(height: 10),


              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Email", mycontroller: email),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Password", mycontroller: password),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          CustomButtonAuth(title: "login", onPressed: () async {
            try {
              DocumentSnapshot AdminDoc = await FirebaseFirestore.instance.collection('Admins').doc(email.text).get();
              if (AdminDoc.exists) {
                if (AdminDoc['password'] == password.text) {
                  // The password is correct, the user is authenticated
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppp()),
                  );
                } else {
                  // The password is incorrect
                  print('Wrong password provided for that user.');
                }
              } else {
                // The user does not exist
                print('No user found for that email.');
              }
            } catch (e) {
              print(e);
            }
          }),
          Container(height: 20),


          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpAdmin()),
              );
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),])),),)]),),);}}