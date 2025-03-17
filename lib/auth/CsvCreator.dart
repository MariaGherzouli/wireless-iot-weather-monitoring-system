import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:share/share.dart';
class TextFileCreator {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTextFile() async {
    String data = '';

    // Get user's reports
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userId = currentUser?.uid ?? '';
    QuerySnapshot querySnapshot = await _firestore.collection('users').doc(userId).collection('reports').get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> report = doc.data() as Map<String, dynamic>;

      // Add report data to text
      data += 'Title: ${report['title']}\n';
      data += 'Content: ${report['content']}\n';
      data += 'Timestamp: ${report['timestamp'].toDate()}\n\n';
    }

    // Write to a file
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = directory.path + "/UserReports.txt";
    File file = File(pathOfTheFileToWrite);
    await file.writeAsString(data);

    print('File created at $pathOfTheFileToWrite');
    Share.shareFiles([pathOfTheFileToWrite], text: 'Here is the exported humidity data.');
  }
}
