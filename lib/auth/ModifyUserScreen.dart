import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import 'ChoiceScreen.dart';


class ModifyUserScreen extends StatefulWidget {
  @override
  _ModifyUserScreenState createState() => _ModifyUserScreenState();
}

class _ModifyUserScreenState extends State<ModifyUserScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> updatePassword() async {
    String email = emailController.text;
    String newPassword = passwordController.text;

    // Hash the new password


    // Update the password in Firestore
    await FirebaseFirestore.instance.collection('users').doc(email).update({
      'password': passwordController.text,
    });

    // Clear the text fields
    emailController.clear();
    passwordController.clear();

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successful action!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple, // I chose a light green color for the background

      body: SingleChildScrollView( // Add this
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.network('https://lottie.host/cc76741a-42c4-4377-bc40-89fcd4674175/4Z5PMcyNY3.json'),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                icon: Icon(Icons.lock_open, size: 24),
                label: Text('Update Password', style: TextStyle(fontSize: 20)),
                onPressed: updatePassword,
              ),
              SizedBox(height: 10), // Add space between the buttons
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ManageUserPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}



// ... Rest of your code ...
