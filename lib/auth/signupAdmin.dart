import 'package:app_iot/auth/login.dart';
import 'package:app_iot/auth/loginAdmin.dart';
import 'package:app_iot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';

import '../components/custombuttonauth.dart';
import '../components/customlogoauth.dart';
import '../components/textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'ChoiceScreen.dart';


class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin({super.key});

  @override
  State<SignUpAdmin> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpAdmin> {
  TextEditingController username = TextEditingController();
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
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 0),
              Lottie.network('https://lottie.host/7b61c89e-13df-432e-bd6f-98a38c38c442/hKKp22GBQv.json'),

              Container(height: 0),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 2),
              CustomTextForm(
                  hinttext: "ُEnter Your username", mycontroller: username),
              Container(height: 5),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 2),
              CustomTextForm(
                  hinttext: "ُEnter Your Email", mycontroller: email),
              Container(height: 2),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 2),
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
          CustomButtonAuth(title: "SignUp", onPressed: () async {
            String usernameText = username.text;
            String emailText = email.text;
            String passwordText = password.text;
            try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailText,
                password: passwordText,
              );
              await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
                'username': username.text,
                'email': email.text,
                'password': password.text,
                'role': 'admin',

              });
              await FirebaseFirestore.instance.collection('Admins').doc(userCredential.user?.uid).set({
                'username': username.text,
                'email': email.text,
                'password': password.text,

              });

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppp()),
              );
            } catch (e) {
              print(e);
            }
          },),

              Container(height: 2),

          Container(height: 2),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginAdmin()),
              );
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
          ]),
      ),
    );
  }
}
