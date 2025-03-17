import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Future<void> submitReport() async {
    String title = titleController.text;
    String content = contentController.text;

    try {
      // Get the current user's UID
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      // Add the report to a new document in the 'reports' subcollection of the user's document
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('reports').add({
        'title': title,
        'content': content,
        'timestamp': DateTime.now(),
      });

      // Clear the text fields
      titleController.clear();
      contentController.clear();
    } catch (error) {
      // Handle error here
      print("Error submitting report: $error");
      // You can show an error message to the user using a snackbar or any other method
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Report'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null, // Allow unlimited lines
            ),
            ElevatedButton(
              child: Text('Submit Report'),
              onPressed: submitReport,
            ),
          ],
        ),
      ),
    );
  }
}
