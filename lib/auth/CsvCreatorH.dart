import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:share/share.dart';
class CsvCreator {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCsv() async {
    List<List<String>> data = [];

    // Add header row
    data.add(['Time', 'Humidity']);

    // Get user's humidity data
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userId = currentUser?.uid ?? '';
    QuerySnapshot querySnapshot = await _firestore.collection('users').doc(userId).collection('humidity').get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> humidityData = doc.data() as Map<String, dynamic>;

      // Add humidity data to CSV
      data.add([
        humidityData['time'].toDate().toString(),
        humidityData['humidity'].toString(),
      ]);
    }

    // Convert to CSV string
    String csvData = const ListToCsvConverter().convert(data);

    // Write to a file
    final directory = await getApplicationDocumentsDirectory();
    final pathOfTheFileToWrite = directory.path + "/UserHumidityData.csv";
    File file = File(pathOfTheFileToWrite);
    await file.writeAsString(csvData);

    // Share the file
    Share.shareFiles([pathOfTheFileToWrite], text: 'Here is the exported humidity data.');
  }
}
