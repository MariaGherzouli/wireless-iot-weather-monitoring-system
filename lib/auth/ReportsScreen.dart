import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import 'CsvCreator.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Reports'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {

              TextFileCreator().createTextFile();

              final directory = await getApplicationDocumentsDirectory();
              final pathOfTheFileToWrite = directory.path + "/UserReports.txt";

              Share.shareFiles([pathOfTheFileToWrite], text: 'User Reports');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('reports').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title']),
                subtitle: Text('Content: ${data['content']}\nTimestamp: ${data['timestamp'].toDate()}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
