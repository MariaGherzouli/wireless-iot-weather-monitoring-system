// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:math';
import 'package:app_iot/auth/ReportScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import flutter_spinkit


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'auth/CsvCreatorH.dart';
import 'auth/InaccessibleScreen.dart';
import 'auth/ReportsScreen.dart';
import 'auth/sensors_state.dart';
import 'auth/signupAdmin.dart';
import 'auth/login.dart';
import 'auth/signup.dart';
import 'auth/soon.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYlTk7xB8fpvZJFVNsKllSuriONM_VD9Y",
      appId: "1:352731563365:android:adf40d64c3438c06d24d8c",
      messagingSenderId: "352731563365",
      projectId: "iotapp-bc8b4",
    ),
  );await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SensorsState(),
      child: MyApp(),
    ),
  );

}


/*class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('==============================User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: {
        "signup" : (context) => SignUp() ,
        "login" : (context) => Login(),
        "homepage" : (context) => Homepage()

      },
    );
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Monitoring',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF800080), // Couleur primaire violet
        hintColor: Color(0xFF6A0DAD),
        backgroundColor: Color(0xFFE1BEE7),// Couleur d'accentuation bleu turquoise vif
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Fond transparent
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.9), // Couleur primaire avec légère transparence
              Theme.of(context).hintColor.withOpacity(0.9), // Couleur d'accentuation avec légère transparence
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(

              // Adjust these values as needed
              child: Lottie.network(
                'https://lottie.host/04abf3ea-52e3-4208-b414-1c0fd3e4f8ff/XSlLK60hu9.json',
               // This will attempt to change the color to blue
              ),
            ),
            buildAnimatedTitle(),

            buildStartButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedTitle() {

    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          FadeAnimatedText(
            'Welcome to Weather Monitoring',
            textStyle: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'E',
              letterSpacing: 2,
              color: Colors.white.withOpacity(0.8), // Make the text slightly transparent
              wordSpacing: 1,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            )
            ,
            duration: Duration(milliseconds: 5000),
            textAlign: TextAlign.center,
          ),
        ],

        repeatForever: true,
      ),
    );
  }

  Widget buildStartButton(BuildContext context) {
    return Positioned(
      bottom: 100.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor.withOpacity(0.8), // Couleur primaire semi-transparente
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: Theme.of(context).hintColor, // Couleur d'accentuation
                width: 2.0,
              ),
            ),
          ),
          icon: Icon(
            Icons.cloud,
            size: 24.0,
            color: Colors.white, // Couleur de l'icône blanche
          ),
          label: Text(
            'Start',
            style: TextStyle(

              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'G',
              letterSpacing: 2,
              color: Colors.white, // Make the text slightly transparent
              wordSpacing: 1,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 2.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isAdmin = false;

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
              Theme.of(context).primaryColor.withOpacity(0.9), // Couleur primaire avec légère transparence
              Theme.of(context).hintColor.withOpacity(0.9), // Couleur d'accentuation avec légère transparence
            ],
          ),
        ),
        child: Stack(
          children: [


            Center(
              child: buildAnimatedWeatherContainer(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isAdmin = !_isAdmin),
        child: Icon(Icons.account_circle),
        backgroundColor: Colors.black54,
      ),
    );
  }

  Widget buildAnimatedWeatherContainer() {
    return GestureDetector(
      onTap: () {
        if (!_isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
      },
      child: Container(
        width: 300.0,
        height: _isAdmin ? 150.0 : 120.0,
        decoration: BoxDecoration(
          color: _isAdmin ? Colors.black54 : Colors.black87, // Black color for user's container
          borderRadius: BorderRadius.circular(20.0),
          gradient: _isAdmin
              ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white70,
              Theme.of(context).primaryColor.withOpacity(0.8), // Couleur primaire avec légère transparence
            ],
          )
              : null, // Pas de dégradé pour l'état utilisateur
          boxShadow: [
            BoxShadow(
              color: _isAdmin ? Colors.grey!.withOpacity(0.5) : Colors.white!.withOpacity(1), // White shadow for user's container
              offset: Offset(2.0, 2.0),
              blurRadius: 10.0,
            ),
          ], // Different box shadow for admin and user
        ),
        child: Stack(
          children: [
            buildAnimatedWeatherIcon(),
            buildAnimatedUserAdminText(),
            buildDecorativeElement(),
          ],
        ),
      ),
    );
  }



  Widget buildAnimatedWeatherIcon() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      top: _isAdmin ? 20.0 : 30.0,
      left: _isAdmin ? 20.0 : 30.0,
      child: Transform.rotate(
        angle: _isAdmin ? 0.0 : -0.2,
        child: Transform.scale(
          scale: _isAdmin ? 1.2 : 1.0,
          child: Icon(
            _isAdmin ? Icons.wb_sunny : Icons.cloud,
            size: 70.0,
            color: Colors.grey, // Couleur de l'icône blanche
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedUserAdminText() {
    return GestureDetector(
      onTap: () {
        if (_isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpAdmin()),
          );
        }
      },
      child: Positioned(
        bottom: 10.0,
        left: 0.0,
        right: 0.0,
        child: Center(
          child: Text(
            _isAdmin ? 'Admin' : 'User',
            style:    TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'E',
            letterSpacing: 2,
            color: Colors.white.withOpacity(0.8), // Make the text slightly transparent
            wordSpacing: 1,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(5.0, 5.0),
              ),
            ],
          )
          ),

        ),
        ),

    );
  }


  Widget buildDecorativeElement() {
    return Positioned(
      top: 0.0,
      right: 0.0,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: _isAdmin ? Theme.of(context).hintColor : Theme.of(context).primaryColor.withOpacity(0.3), // Couleur d'accentuation pour l'administrateur, couleur primaire plus claire pour l'utilisateur
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0)),

        ),
        child: Icon(
          _isAdmin ? Icons.flash_on : Icons.cloud_queue, // Icônes d'exemple pour la démonstration
          color: Colors.white, // Couleur de l'icône blanche
        ),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(

          children: [
            Lottie.network(alignment: Alignment(30, 20),'https://lottie.host/67a597c5-2a84-44e2-8d83-0d1b426a7c74/L0BlEIwuBB.json' ),

            buildDataScreenContent(context),

          ],
        ),
      ),
    );
  }

  Widget buildDataScreenContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 230,),
        Container(
          width: 300.0,
          height: 120.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
               Colors.purple.withOpacity(0.9), // Couleur primaire avec légère transparence
                Colors.purpleAccent[700]!.withOpacity(0.9), // Couleur d'accentuation avec légère transparence
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(1),
                spreadRadius: 3,
                offset: Offset(1.0, 1.0),
                blurRadius: 25.0, // changes position of shadow
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RadialMenu())); // Logique à exécuter lorsque le bouton "View Data" est pressé
              print('View Data button pressed');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.cloud,
                    size: 40.0,
                    color: Colors.grey[300], // Couleur de l'icône gris clair
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'View Data',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white, // Couleur du texte blanc
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: 300.0,
          height: 120.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.withOpacity(0.9), // Couleur primaire avec légère transparence
                Colors.purpleAccent[700]!.withOpacity(0.9), // Couleur d'accentuation avec légère transparence
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(1),
                spreadRadius: 4,
                offset: Offset(1.0, 1.0),
                blurRadius: 25.0, // changes position of shadow
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {
              // Logique à exécuter lorsque le bouton "Fetch Data" est pressé
              Navigator.push(context, MaterialPageRoute(builder: (context) => RadialMenu2())); // Logique à exécuter lorsque le bouton "View Data" est pressé
              print('View Data button pressed');
              print('Fetch Data button pressed');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.wb_sunny,
                    size: 40.0,
                    color: Colors.white, // Couleur de l'icône blanche
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Fetch Data',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white, // Couleur du texte blanc
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RadialMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {

        '/temperature': (context) => MenuScreen(),
        '/wind': (context) => Soon(),
       '/humidity': (context) => MenuScreenH(),
        '/rain': (context) => Soon(),
        '/inaccessible': (context) => InaccessibleScreen(), // Add this line
      },
      theme: ThemeData(
        primaryColor: Colors.purple.withOpacity(0.9),  // Couleur primaire bleu profondColors.purple.withOpacity(0.9), // Couleur primaire avec légère transparence

        hintColor:  Colors.purpleAccent[700]!.withOpacity(0.9),  // Couleur d'accentuation bleu turquoise vif
        scaffoldBackgroundColor: Colors.black, // Fond transparent
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
      home: Scaffold(

        backgroundColor: Colors.black, // Fond transparent
        body:
        Container(


          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: RadialMenuWidget(),
          ),
        ),
      ),
    );
  }
}

class RadialMenuWidget extends StatefulWidget {
  @override
  _RadialMenuWidgetState createState() => _RadialMenuWidgetState();
}

class _RadialMenuWidgetState extends State<RadialMenuWidget> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _translateButton;
  late Animation<double> _rotateButton;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _rotateButton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _translateButton = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget sensorButton(double angle, {required String label, required String sensor, required Color color, required Color highlightColor, required BoxShadow boxShadow}) {
    final double rad = angle * (pi / 180);
    return Consumer<SensorsState>(
      builder: (context, sensorsState, child) {
        return SizedBox(
          width: 150.0,
          height: 190.0,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(
                (_translateButton.value) * cos(rad),
                (_translateButton.value) * sin(rad),
              ),
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [boxShadow], // Use the boxShadow parameter here
                ),
                child: Material(
                  color: color,
                  child: InkWell(
                    onTap: () {
                      if ((sensor == 'Temperature' && sensorsState.isTemperatureSensorActive) ||
                          (sensor == 'Humidity' && sensorsState.isHumiditySensorActive)) {
                        Navigator.pushNamed(context, '/$sensor'.toLowerCase());
                      } else {
                        Navigator.pushNamed(context, '/inaccessible');
                      }
                    },
                    highlightColor: highlightColor,
                    child: Container(
                      width: 150.0,
                      height: 190.0,
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  void toggle() {
    if (isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      alignment: Alignment.center,
      children: <Widget>[

        sensorButton(0, label: 'Rain Sensor', sensor: 'Rain', color: Theme.of(context).hintColor, // Couleur primaire avec légère transparence
        highlightColor:  Colors.cyanAccent.withOpacity(1),boxShadow: BoxShadow(
            color: Colors.cyanAccent.withOpacity(1),
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
          ),),
        sensorButton(90, label: 'Temperature Sensor', sensor: 'Temperature', color: Theme.of(context).primaryColor,  highlightColor:  Colors.cyanAccent.withOpacity(1),boxShadow: BoxShadow(
          color: Colors.cyanAccent.withOpacity(1),
          offset: Offset(2.0, 2.0),
          blurRadius: 10.0,
        ),),
        sensorButton(180, label: 'Wind Sensor', sensor: 'Wind', color: Theme.of(context).hintColor,  highlightColor:  Colors.cyanAccent.withOpacity(1),boxShadow: BoxShadow(
          color: Colors.cyanAccent.withOpacity(1),
          offset: Offset(2.0, 2.0),
          blurRadius: 10.0,
        ),),
        sensorButton(270, label: 'Humidity Sensor', sensor: 'Humidity', color: Theme.of(context).primaryColor,  highlightColor:  Colors.cyanAccent.withOpacity(1),boxShadow: BoxShadow(
          color: Colors.cyanAccent.withOpacity(1),
          offset: Offset(2.0, 2.0),
          blurRadius: 10.0,
        ),),
        FractionallySizedBox(
          widthFactor: 0.4,
          heightFactor: 0.5,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: toggle,
            tooltip: 'Choose Sensor',
            child: Text(
              'Choose Sensor',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),

            ),
          ),
        ),
      ],
    );
  }
}


enum TimePeriod {
  Day,
  Week,
  Month,
}

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  late double _latestData; // Variable to store the latest temperature data
  late List<TemperatureData> _allData; // Raw unfiltered data
  late List<TemperatureData> _filteredData; // Data filtered based on selected period
  late List<charts.Series<TemperatureData, DateTime>> _seriesData; // Data for chart
  TimePeriod _selectedPeriod = TimePeriod.Day;
  double _currentTemperature = 0.0; // Store current temperature

  @override
  void initState() {
    super.initState();
    _latestData = 0.0; // Initialize with default value
    _allData = []; // Initialize empty list
    _filteredData = [];
    _seriesData = [];
    _fetchData(); // Fetch data on widget initialization
  }

  // Method to fetch temperature data from Firebase

  void _fetchData() {
    //_allData.clear();
    List<double> dataTemperature = [];
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userId = currentUser?.uid ?? '';
    final String userEmail = currentUser?.email ?? '';
    final _temperatureRef = FirebaseDatabase.instance.reference().child('hum');
    final _humidityRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('humidity');

    _temperatureRef.onValue.listen((event) async {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final value = snapshot.value;
        if (value is int) {
          setState(() {
            _currentTemperature = value.toDouble(); // Convertir l'entier en double
            print('Humidité récupérée: $_currentTemperature'); // Pour le débogage
            dataTemperature.add(_currentTemperature); // Ajouter la valeur à dataTemperature
            print('dataTemperature: $dataTemperature'); // Imprimer dataTemperature pour le débogage
            print('dataTemperature:');
            _allData.add(TemperatureData(DateTime.now(), _currentTemperature)); // Ajouter les données à allData
            _updateChartData(); // Mettre à jour les données du graphique avec les nouvelles données de température// Update chart data with new temperature data
            print('dataTemperature after fetchData: $dataTemperature');
            print('Final dataTemperature: '); // Imprimer dataTemperature après avoir terminé la récupération des données
          });

          // Store the data in the 'humidity' collection
          await _humidityRef.add({
            'time': DateTime.now(),
            'humidity': _currentTemperature,
            'email': userEmail,  // Store the user's email
          });
        } else {
          print('Unexpected data type for humidity: ${value.runtimeType}');
        }
      } else {
        print('No humidity data found in Firebase');
      }
    });

    // Fetch data from 'humidity' collection in Firestore
    _humidityRef.snapshots().listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _currentTemperature = data['humidity'];
          print('Humidity retrieved: $_currentTemperature');
          _allData.add(TemperatureData(data['time'].toDate(), _currentTemperature));
          _allData.sort((a, b) => a.time.compareTo(b.time));

          _updateChartData();
        });
      });
    });
  }





  void _updateChartData() {
    _filteredData = _filterData(_allData, _selectedPeriod); // Filtrer les données basées sur la période sélectionnée
    _seriesData = _createBarChartData(_allData); // Créer le graphique avec toutes les données disponibles
    setState(() {}); // Déclencher une reconstruction pour refléter les données mises à jour dans l'interface utilisateur
  }



  List<TemperatureData> _filterData(List<TemperatureData> data, TimePeriod period) {
    switch (period) {
      case TimePeriod.Day:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList();
      case TimePeriod.Week:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
      case TimePeriod.Month:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 30)))).toList();
      default:
        return data; // Si aucune période n'est sélectionnée, retourner toutes les données
    }
  }


  List<charts.Series<TemperatureData, DateTime>> _createBarChartData(List<TemperatureData> data) {
    return [
      charts.Series(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TemperatureData data, _) => data.time,
        measureFn: (TemperatureData data, _) => data.temperature,
        data: data,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Lottie.network('https://lottie.host/c5318fbf-63df-43fd-af63-e89844a5cef7/D8HJ5GQW4E.json'),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                ],
              ),


              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Visualisations de donnée :',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: charts.TimeSeriesChart(
                          _seriesData,
                          animate: true,
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              zeroBound: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              AnimatedExportButton(),




            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);
}
class AnimatedExportButton extends StatefulWidget {
  @override
  _AnimatedExportButtonState createState() => _AnimatedExportButtonState();
}

class _AnimatedExportButtonState extends State<AnimatedExportButton> {
  bool _isPressed = false;

  void _onPressButton() {
    CsvCreator().createCsv();
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onPressButton(),
      onTapUp: (details) => _onPressButton(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blueGrey: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: _isPressed ? 0 : 6,
              offset: Offset(0, _isPressed ? 0 : 3),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {
            CsvCreator().createCsv();
          },
          child: Text(
            'Export Data',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  double _temperature = 0.0; // Store retrieved temperature

  Future<void> _fetchData() async {
    final database = FirebaseDatabase.instance.reference().child('temp');
    try {
      final snapshot = await database.once();
      if (snapshot.snapshot.value != null) {
        final value = snapshot.snapshot.value;
        if (value is int) {
          setState(() {
            _temperature = value.toDouble(); // Convert integer to double
            print('Temperature retrieved: $_temperature'); // For debugging
          });
        } else {
          print('Unexpected data type for temperature: ${value.runtimeType}');
        }
      } else {
        print('No temperature data found in Firebase');
      }
    } catch (error) {
      print('Error fetching temperature data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: [
          // Background Sun Animation
          AnimatedSun(),

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Temperature',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 40.0),

                // Circular Progress Indicator
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.lightBlueAccent.withOpacity(0.8),
                        Colors.yellowAccent.withOpacity(0.3),
                      ],
                      center: Alignment.center,
                      radius: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellowAccent.withOpacity(0.5),
                        blurRadius: 20.0,
                        spreadRadius: 5.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 80.0,
                    ),
                  ),
                ),
                SizedBox(height: 40.0),

                // Animated Temperature Text
                Text(
                  '$_temperature°C',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'MyCustomFont',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.0),

                // High Temperature Alert (Example)
                if (_temperature > 30.0) ...[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High Temperature Alert!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedSun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.yellow.shade100,
                    Colors.yellow.shade400,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -100,
            top: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade200,
                    blurRadius: 100,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -120,
            top: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade300,
                    blurRadius: 100,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -150,
            top: -150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade400,
                    blurRadius: 100,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent,
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorChangingText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  ColorChangingText({required this.text, required this.textStyle});

  @override
  _ColorChangingTextState createState() => _ColorChangingTextState();
}

class _ColorChangingTextState extends State<ColorChangingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.orange,
    ).animate(_controller)
      ..addListener(() {
        setState(() {}); // Trigger rebuild when color changes
      });
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: widget.textStyle.copyWith(color: _colorAnimation.value),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}





class HumidityScreen extends StatefulWidget {
  @override
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  double _humidity = 0.0; // Store retrieved humidity

  Future<void> _fetchData() async {
    final database = FirebaseDatabase.instance.reference().child('hum');
    try {
      final snapshot = await database.once();
      if (snapshot.snapshot.value != null) {
        final value = snapshot.snapshot.value;
        if (value is int) {
          setState(() {
            _humidity = value.toDouble(); // Convert integer to double
            print('Humidity retrieved: $_humidity'); // For debugging
          });
        } else {
          print('Unexpected data type for humidity: ${value.runtimeType}');
        }
      } else {
        print('No humidity data found in Firebase');
      }
    } catch (error) {
      print('Error fetching humidity data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    String lottieUrl='';
    if (_humidity > 40) {
      lottieUrl = 'https://lottie.host/42d0e0b8-bcc5-47e3-bd67-29315ea657fc/PCghWuKMT9.json';
    } else if (_humidity < 40 && _humidity > 10) {
      lottieUrl = 'https://lottie.host/c5a1e610-8939-4831-9343-1e2d56649156/79oMSG6nuL.json';
    } else if (_humidity < 10) {
      lottieUrl = 'https://lottie.host/c5a1e610-8939-4831-9343-1e2d56649156/79oMSG6nuL.json';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Rain Animation

          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title

                SizedBox(height: 1.0),

                // Sensor Icon and Text
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Lottie.network(
                        lottieUrl,
                        height: 300, // Adjust height as needed
                        width: 450, // Adjust width as needed
                      ),
                    ),
                  ],
                ),
               SizedBox(height: 30,),
                // Animated Humidity Text
                ColorChangingText(
                  text: '$_humidity%',
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'G',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.0),

                // High Humidity Alert
                // High Humidity Alert
                AnimatedOpacity(
                  opacity: _isAlertVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: SlideInUp(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      // Add padding to the right side
                      child: SingleChildScrollView(  // Add this
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'High Humidity Alert!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Positioned Content
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        onPressed: () => _showHumidityAlert(context),
                      ),
                      Visibility(
                        visible: _humidity > 30.0,
                        child: Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isAlertVisible = false; // Flag to control alert visibility

  void _showHumidityAlert(BuildContext context) {
    setState(() {
      _isAlertVisible = true;
    });
  }
}

  class SlideInUp extends StatefulWidget {
  final Widget child;

  SlideInUp({required this.child});

  @override
  _SlideInUpState createState() => _SlideInUpState();
}

class _SlideInUpState extends State<SlideInUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class AnimatedRain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.blue.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              child: CustomPaint(
                painter: RainPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 200; i++) {
      final random = Random();
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final endX = startX + random.nextDouble() * 3;
      final endY = startY + random.nextDouble() * 10 + 10;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
  class TemperatureCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.sunny,
          size: 80.0,
          color: Colors.yellow,
        ),
      ),
    );
  }
}


/*class HumidityCircle extends StatelessWidget {
  final double humidity;

  HumidityCircle({required this.humidity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.water_drop,
          size: 80.0,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}*/


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to Home Screen!',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class DataTileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const DataTileButton({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor.withOpacity(0.8), // Couleur primaire semi-transparente
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).hintColor, // Couleur d'accentuation
            width: 2.0,
          ),
        ),
      ),
      icon: Icon(
        icon,
        size: 24.0,
        color: iconColor,
      ),
      label: Text(
        title,
        style: TextStyle(
          color: Colors.white, // Couleur du texte blanc
          fontSize: 16.0,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(1.0, 1.0),
              blurRadius: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            buildMenuScreenContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildMenuScreenContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Data Visualization Button
        buildDataButton(context, "Data Visualization", Icons.bar_chart, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TemperatureRealScreen()));
          print('Data Visualization button pressed');
        }),
        SizedBox(height: 20),
        // Statistics Button
        buildDataButton(context, "Statistics", Icons.wb_sunny, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageT()));
          // Logic to execute when the "Statistics" button is pressed
          print('Statistics button pressed');
        }),
        SizedBox(height: 20),
        // Export Data Button
        buildDataButton(context, "Export Data", Icons.file_download, () {
          // Logic to execute when the "Export Data" button is pressed
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsScreen()));
          print('Export Data button pressed');
        }),
        SizedBox(height: 20),
        // Write Reports Button
        buildDataButton(context, "Write Reports", Icons.note_add, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen()));
          // Logic to execute when the "Write Reports" button is pressed
          print('Write Reports button pressed');
        }),
      ],
    );
  }

  Widget buildDataButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Container(
      width: 300.0,
      height: 120.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withOpacity(0.9), // Couleur primaire avec légère transparence
            Colors.purpleAccent[700]!.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(1),
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
class MenuScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            buildMenuScreen1Content(context),
          ],
        ),
      ),
    );
  }

  Widget buildMenuScreen1Content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Data Visualization Button
        buildDataButton(context, "Data Visualization", Icons.bar_chart, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HumidityScreen1()));
          print('Data Visualization button pressed');
        }),
        SizedBox(height: 20),
        // Statistics Button
        buildDataButton(context, "Statistics", Icons.wb_sunny, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
          // Logic to execute when the "Statistics" button is pressed
          print('Statistics button pressed');
        }),
        SizedBox(height: 20),
        // Export Data Button
        buildDataButton(context, "Export Data", Icons.file_download, () {
          // Logic to execute when the "Export Data" button is pressed
          print('Export Data button pressed');
        }),
        SizedBox(height: 20),
        // Write Reports Button
        buildDataButton(context, "Write Reports", Icons.note_add, () {
          // Logic to execute when the "Write Reports" button is pressed
          print('Write Reports button pressed');
        }),
      ],
    );
  }

  Widget buildDataButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Container(
      width: 300.0,
      height: 120.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.9),
            Theme.of(context).hintColor.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!.withOpacity(0.3),
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _minimumTemperatureAnimation;
  late Animation<double> _averageAnimation;
  late Animation<double> _maximumAnimation;
  late Animation<double> _medianAnimation;

  // Static temperature data for testing
  List<double> temperatures = [1, 2, 2, 2, 2, 2999, 30];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Calculate statistics
    double minTemperature = calculateMinTemperature();
    double maxTemperature = calculateMaxTemperature();
    double averageTemperature = calculateAverageTemperature();
    double medianTemperature = calculateMedianTemperature();

    _minimumTemperatureAnimation = Tween<double>(
      begin: 0,
      end: minTemperature,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _averageAnimation = Tween<double>(
      begin: 0,
      end: averageTemperature,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _maximumAnimation = Tween<double>(
      begin: 0,
      end: maxTemperature,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _medianAnimation = Tween<double>(
      begin: 0,
      end: medianTemperature,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  // Function to calculate the minimum temperature
  double calculateMinTemperature() {
    return temperatures.reduce(min);
  }

  // Function to calculate the maximum temperature
  double calculateMaxTemperature() {
    return temperatures.reduce(max);
  }

  // Function to calculate the average temperature
  double calculateAverageTemperature() {
    double sum = temperatures.reduce((a, b) => a + b);
    return sum / temperatures.length;
  }

  // Function to calculate the median temperature
  double calculateMedianTemperature() {
    List<double> sortedTemperatures = [...temperatures];
    sortedTemperatures.sort();
    int middleIndex = sortedTemperatures.length ~/ 2;
    if (sortedTemperatures.length % 2 == 0) {
      return (sortedTemperatures[middleIndex - 1] +
          sortedTemperatures[middleIndex]) /
          2;
    } else {
      return sortedTemperatures[middleIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return CircularProgressIndicator();
    }

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
         color: Colors.black,
          child: Stack(
            children: [
              Positioned(
                top: -100,
                left: -100,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(0.1),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: -50,
                child: Icon(
                  Icons.cloud,
                  size: 100,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Current Readings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellowAccent.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [   Colors.purple,
                                Colors.purpleAccent, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Minimum',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMinTemperature()}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _minimumTemperatureAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _minimumTemperatureAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_minimumTemperatureAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [   Colors.purple,
                                Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Maximum',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMaxTemperature()}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _maximumAnimation.value,
                                      backgroundColor: Colors.yellow.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _maximumAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_maximumAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors:  [Colors.purple,Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Average',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateAverageTemperature().toStringAsFixed(2)}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _averageAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _averageAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_averageAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors:  [Colors.purple,Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Median',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMedianTemperature().toStringAsFixed(2)}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _medianAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _medianAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_medianAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RadialMenu2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {

        //'/temperature': (context) => MenuScreen2(),
        '/wind': (context) => Soon(),
        '/humidity': (context) => HumidityScreen(),
        '/welcome': (context) => Soon(),
        '/rain': (context) => Soon(),
        '/inaccessible': (context) => InaccessibleScreen(), // Add this line
      },
      theme: ThemeData(
        primaryColor: Colors.purple, // Couleur primaire bleu profond
        hintColor: Colors.purpleAccent, // Couleur d'accentuation bleu turquoise vif
        scaffoldBackgroundColor: Colors.black, // Fond transparent
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black, // Fond transparent
        body: Container(
          color: Colors.black,
          child: Center(
            child: RadialMenuWidget(),
          ),
        ),
      ),
    );
  }
}

class MenuScreen2 {
}

class RadialMenuWidget2 extends StatefulWidget {
  @override
  _RadialMenuWidgetState2 createState() => _RadialMenuWidgetState2();
}

class _RadialMenuWidgetState2 extends State<RadialMenuWidget2> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _translateButton;
  late Animation<double> _rotateButton;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _rotateButton = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _translateButton = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget sensorButton(double angle, {required String label, required String sensor, required Color color, required Color highlightColor}) {
    final double rad = angle * (pi / 180);
    return SizedBox(
      width: 150.0,
      height: 190.0,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            (_translateButton.value) * cos(rad),
            (_translateButton.value) * sin(rad),
          ),
        child: ClipOval(
          child: Material(
            color: color,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/$sensor'.toLowerCase());
              },
              highlightColor: highlightColor,
              child: Container(
                width: 150.0,
                height: 190.0,
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggle() {
    if (isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        sensorButton(0, label: 'Rain Sensor', sensor: 'Rain', color: Theme.of(context).hintColor, highlightColor: Theme.of(context).hintColor),
        sensorButton(90, label: 'Temperature Sensor', sensor: 'Temperature', color: Theme.of(context).primaryColor, highlightColor: Theme.of(context).hintColor),
        sensorButton(180, label: 'Wind Sensor', sensor: 'Wind', color: Theme.of(context).hintColor, highlightColor: Theme.of(context).hintColor),
        sensorButton(270, label: 'Humidity Sensor', sensor: 'Humidity', color: Theme.of(context).primaryColor, highlightColor: Theme.of(context).hintColor),
        FractionallySizedBox(
          widthFactor: 0.4,
          heightFactor: 0.5,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: toggle,
            tooltip: 'Choose Sensor',
            child: Text(
              'Choose Sensor',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HumidityScreen1 extends StatefulWidget {
  const HumidityScreen1({Key? key}) : super(key: key);

  @override
  _HumidityScreen1State createState() => _HumidityScreen1State();
}

class _HumidityScreen1State extends State<HumidityScreen1> {
  late List<TemperatureData> _allData; // Raw unfiltered data
  late List<TemperatureData> _filteredData; // Data filtered based on selected period
  late List<charts.Series<TemperatureData, DateTime>> _seriesData; // Data for chart
  TimePeriod _selectedPeriod = TimePeriod.Day;
  double _currentTemperature = 0.0; // Store current temperature

  // Reference to the Firebase Database location for temperature data
  Future<void> _fetchData() async {
    final _temperatureRef = FirebaseDatabase.instance.reference().child('hum');
    try {
      final snapshot = await _temperatureRef.once();
      if (snapshot.snapshot.value != null) {
        final value = snapshot.snapshot.value;
        if (value is int) {
          setState(() {
            _currentTemperature = value.toDouble(); // Convert integer to double
            print('Humidity retrieved: $_currentTemperature'); // For debugging
          });
          _allData.add(TemperatureData(DateTime.now(), _currentTemperature));
          _updateChartData(); // Update chart data with new temperature data
        } else {
          print('Unexpected data type for humidity: ${value.runtimeType}');
        }
      } else {
        print('No humidity data found in Firebase');
      }
    } catch (error) {
      print('Error fetching humidity data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _allData = []; // Initialize empty list
    _filteredData = [];
    _seriesData = [];
    _fetchData(); // Fetch data on widget initialization
  }

  void _updateChartData() {
    _filteredData = _filterData(_allData, _selectedPeriod);
    _seriesData = _createBarChartData(_filteredData);
    setState(() {}); // Trigger a rebuild to reflect the updated data in the UI
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Sensor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time Period:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  DropdownButton<TimePeriod>(
                    value: _selectedPeriod,
                    items: TimePeriod.values.map((TimePeriod period) {
                      return DropdownMenuItem<TimePeriod>(
                        value: period,
                        child: Text(
                          period.toString().split('.').last, // Extract enum name
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }).toList(),
                    onChanged: (TimePeriod? newPeriod) {
                      if (newPeriod != null) {
                        setState(() {
                          _selectedPeriod = newPeriod;
                          _filteredData = _filterData(_allData, _selectedPeriod); // Filter data based on selected period
                          _seriesData = _createBarChartData(_filteredData); // Update chart data
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Visualizations de données :',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: charts.TimeSeriesChart(
                          _seriesData,
                          animate: true,
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              zeroBound: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Current Temperature: $_currentTemperature°C',
                style: TextStyle(fontSize: 18.0 ,color: Colors.white),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _exportData,
                child: Text('Export Data (CSV)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to load temperature data from a real data source (e.g., database)
  List<TemperatureData> _loadTemperatureDataFromDatabase() {
    // Simulated method to load temperature data from a database
    // Replace this with your actual data loading logic
    return List.generate(100, (index) {
      return TemperatureData(
        DateTime.now().subtract(Duration(days: index)), // Simulate timestamps for past 100 days
        Random().nextDouble() * 50, // Simulate temperature values between 0 and 50
      );
    });
  }

  // Method to filter temperature data based on the selected time period
  List<TemperatureData> _filterData(List<TemperatureData> data, TimePeriod period) {
    // Simulated method to filter temperature data
    // Replace this with your actual data filtering logic
    switch (period) {
      case TimePeriod.Day:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList();
      case TimePeriod.Week:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
      case TimePeriod.Month:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 30)))).toList();
    }
  }

  // Method to create bar chart data from filtered temperature data
  List<charts.Series<TemperatureData, DateTime>> _createBarChartData(List<TemperatureData> data) {
    return [
      charts.Series(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TemperatureData data, _) => data.time,
        measureFn: (TemperatureData data, _) => data.temperature,
        data: data,
      )
    ];
  }

  // Placeholder method for exporting data (not implemented in this example)
  void _exportData() {
    // Placeholder method for exporting data to CSV
    // Implement your logic for exporting data to CSV here
    print('Exporting data to CSV...');
  }
}

class HumidityData {
  final DateTime time;
  final double Humidity;

  HumidityData(this.time, this.Humidity);
}

class MyPageH extends StatefulWidget {
  @override
  _MyPageStateH createState() => _MyPageStateH();
}

class _MyPageStateH extends State<MyPageH> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _minimumTemperatureAnimation;
  late Animation<double> _averageAnimation;
  late Animation<double> _maximumAnimation;
  late Animation<double> _medianAnimation;

  // Replace static data with data from Firestore
  List<double> humidity = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Fetch humidity data from Firestore
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('humidity')
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        querySnapshot.docChanges.forEach((docChange) {
          if (docChange.type == DocumentChangeType.added) {
            Map<String, dynamic> data = docChange.doc.data() as Map<
                String,
                dynamic>;
            setState(() {
              double currentHumidity = data['humidity'];
              humidity.add(currentHumidity);


              // Calculate statistics
              double minHumidity = calculateMinHumidity();
              double maxHumidity = calculateMaxHumidity();
              double averageHumidity = calculateAverageHumidity();
              double medianHumidity = calculateMedianHumidity();

              // Rest of your code...
              // Initialize animations here
              _minimumTemperatureAnimation = Tween<double>(
                begin: 0,
                end: minHumidity,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _averageAnimation = Tween<double>(
                begin: 0,
                end: averageHumidity,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _maximumAnimation = Tween<double>(
                begin: 0,
                end: maxHumidity,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _medianAnimation = Tween<double>(
                begin: 0,
                end: medianHumidity,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );
            });
          }});
      });
    }
  }

  // Function to calculate the minimum temperature
  double calculateMinHumidity() {
    double minHumidity = humidity.reduce(min);
    print('Min Humidity: $minHumidity');
    return minHumidity;
  }

  // Function to calculate the maximum temperature
  double calculateMaxHumidity() {
    double maxHumidity = humidity.reduce(max);
    print('Max Humidity: $maxHumidity');
    return maxHumidity;
  }

  // Function to calculate the average temperature
  double calculateAverageHumidity() {
    double sum = humidity.reduce((a, b) => a + b);
    return sum / humidity.length;
  }

  // Function to calculate the median temperature
  double calculateMedianHumidity() {
    List<double> sortedHumidity = [...humidity];
    sortedHumidity.sort();
    int middleIndex = sortedHumidity.length ~/ 2;
    if (sortedHumidity.length % 2 == 0) {
      return (sortedHumidity[middleIndex - 1] +
          sortedHumidity[middleIndex]) /
          2;
    } else {
      return sortedHumidity[middleIndex];
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: -100,
                left: -100,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(0.1),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: -50,
                child: Icon(
                  Icons.cloud,
                  size: 100,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Current Readings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellowAccent.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [   Colors.purple,
                                Colors.purpleAccent, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Minimum',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMinHumidity()}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _minimumTemperatureAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _minimumTemperatureAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_minimumTemperatureAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [   Colors.purple,
                                Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Maximum',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMaxHumidity()}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _maximumAnimation.value,
                                      backgroundColor: Colors.yellow.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _maximumAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_maximumAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors:  [Colors.purple,Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Average',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateAverageHumidity().toStringAsFixed(2)}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _averageAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _averageAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_averageAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors:  [Colors.purple,Colors.purple, ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                'Median',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Current: ${calculateMedianHumidity().toStringAsFixed(2)}°C',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    'Location: humifity Living Room',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      value: _medianAnimation.value,
                                      backgroundColor: Colors.grey.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: _medianAnimation.value * 6.3,
                                    child: Container(
                                      width: 3,
                                      height: 90,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${(_medianAnimation.value ).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}























class MenuScreenH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            buildMenuScreen2Content(context),
          ],
        ),
      ),
    );
  }

  Widget buildMenuScreen2Content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Data Visualization Button
        buildDataButton(context, "Data Visualization", Icons.bar_chart, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TemperatureScreen()));
          print('Data Visualization button pressed');
        }),
        SizedBox(height: 20),
        // Statistics Button
        buildDataButton(context, "Statistics", Icons.wb_sunny, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageH()));
          // Logic to execute when the "Statistics" button is pressed
          print('Statistics button pressed');
        }),
        SizedBox(height: 20),
        // Export Data Button
        buildDataButton(context, "Export Data", Icons.file_download, () {
          // Logic to execute when the "Export Data" button is pressed
          print('Export Data button pressed');
        }),
        SizedBox(height: 20),
        // Write Reports Button
        buildDataButton(context, "Write Reports", Icons.note_add, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReportScreen()));
          // Logic to execute when the "Write Reports" button is pressed
          print('Write Reports button pressed');
        }),
      ],
    );
  }

  Widget buildDataButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Container(
      width: 300.0,
      height: 120.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withOpacity(0.9), // Couleur primaire avec légère transparence
            Colors.purpleAccent[700]!.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(1),
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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





class TemperatureRealScreen extends StatefulWidget {
  const TemperatureRealScreen({Key? key}) : super(key: key);

  @override
  _TemperatureRealScreenState createState() => _TemperatureRealScreenState();
}

class _TemperatureRealScreenState extends State<TemperatureRealScreen> {
  late double _latestData; // Variable to store the latest temperature data
  late List<TemperatureRealData> _allData; // Raw unfiltered data
  late List<TemperatureRealData> _filteredData; // Data filtered based on selected period
  late List<charts.Series<TemperatureRealData, DateTime>> _seriesData; // Data for chart
  TimePeriod _selectedPeriod = TimePeriod.Day;
  double _currentTemperatureReal = 0.0; // Store current temperature

  @override
  void initState() {
    super.initState();
    _latestData = 0.0; // Initialize with default value
    _allData = []; // Initialize empty list
    _filteredData = [];
    _seriesData = [];
    _fetchData(); // Fetch data on widget initialization
  }

  // Method to fetch temperature data from Firebase

  void _fetchData() {
    //_allData.clear();
    List<double> dataTemperatureReal = [];
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String userId = currentUser?.uid ?? '';
    final String userEmail = currentUser?.email ?? '';
    final _temperatureRealRef = FirebaseDatabase.instance.reference().child('number');
    final _temperatureRealCollectionRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('temperatureReal');

    _temperatureRealRef.onValue.listen((event) async {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final value = snapshot.value;
        if (value is double) {
          setState(() {
            _currentTemperatureReal = value.toDouble(); // Convertir l'entier en double
            print('TemperatureReal récupérée: $_currentTemperatureReal'); // Pour le débogage
            dataTemperatureReal.add(_currentTemperatureReal); // Ajouter la valeur à dataTemperatureReal
            print('dataTemperatureReal: $dataTemperatureReal'); // Imprimer dataTemperatureReal pour le débogage
            print('dataTemperatureReal:');
            _allData.add(TemperatureRealData(DateTime.now(), _currentTemperatureReal)); // Ajouter les données à allData
            _updateChartData(); // Mettre à jour les données du graphique avec les nouvelles données de température// Update chart data with new temperature data
            print('dataTemperatureReal after fetchData: $dataTemperatureReal');
            print('Final dataTemperatureReal: '); // Imprimer dataTemperatureReal après avoir terminé la récupération des données
          });

          // Store the data in the 'temperatureReal' collection
          await _temperatureRealCollectionRef.add({
            'time': DateTime.now(),
            'temperatureReal': _currentTemperatureReal,
            'email': userEmail,  // Store the user's email
          });
        } else {
          print('Unexpected data type for temperatureReal: ${value.runtimeType}');
        }
      } else {
        print('No temperatureReal data found in Firebase');
      }
    });

    // Fetch data from 'temperatureReal' collection in Firestore
    _temperatureRealCollectionRef.snapshots().listen((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _currentTemperatureReal = data['temperatureReal'];
          print('TemperatureReal retrieved: $_currentTemperatureReal');
          _allData.add(TemperatureRealData(data['time'].toDate(), _currentTemperatureReal));
          _allData.sort((a, b) => a.time.compareTo(b.time));

          _updateChartData();
        });
      });
    });
  }

  void _updateChartData() {
    _filteredData = _filterData(_allData, _selectedPeriod); // Filtrer les données basées sur la période sélectionnée
    _seriesData = _createBarChartData(_allData); // Créer le graphique avec toutes les données disponibles
    setState(() {}); // Déclencher une reconstruction pour refléter les données mises à jour dans l'interface utilisateur
  }

  List<TemperatureRealData> _filterData(List<TemperatureRealData> data, TimePeriod period) {
    switch (period) {
      case TimePeriod.Day:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList();
      case TimePeriod.Week:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
      case TimePeriod.Month:
        return data.where((element) => element.time.isAfter(DateTime.now().subtract(Duration(days: 30)))).toList();
      default:
        return data; // Si aucune période n'est sélectionnée, retourner toutes les données
    }
  }

  List<charts.Series<TemperatureRealData, DateTime>> _createBarChartData(List<TemperatureRealData> data) {
    return [
      charts.Series(
        id: 'TemperatureReal',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TemperatureRealData data, _) => data.time,
        measureFn: (TemperatureRealData data, _) => data.temperatureReal,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Lottie.network('https://lottie.host/c5318fbf-63df-43fd-af63-e89844a5cef7/D8HJ5GQW4E.json'),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                ],
              ),

              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Visualisations de donnée :',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: charts.TimeSeriesChart(
                          _seriesData,
                          animate: true,
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            tickProviderSpec: charts.BasicNumericTickProviderSpec(
                              zeroBound: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              AnimatedExportButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureRealData {
  final DateTime time;
  final double temperatureReal;

  TemperatureRealData(this.time, this.temperatureReal);
}
class MyPageT extends StatefulWidget {
  @override
  _MyPageStateT createState() => _MyPageStateT();
}

class _MyPageStateT extends State<MyPageT> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _minimumTemperatureRealAnimation;
  late Animation<double> _averageAnimation;
  late Animation<double> _maximumAnimation;
  late Animation<double> _medianAnimation;

  // Replace static data with data from Firestore
  List<double> temperatureReal = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Fetch temperatureReal data from Firestore
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('temperatureReal')
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        querySnapshot.docChanges.forEach((docChange) {
          if (docChange.type == DocumentChangeType.added) {
            Map<String, dynamic> data = docChange.doc.data() as Map<
                String,
                dynamic>;
            setState(() {
              double currentTemperatureReal = data['temperatureReal'].toDouble();
              temperatureReal.add(currentTemperatureReal);


              // Calculate statistics
              double minTemperatureReal = calculateMinTemperatureReal();
              double maxTemperatureReal = calculateMaxTemperatureReal();
              double averageTemperatureReal = calculateAverageTemperatureReal();
              double medianTemperatureReal = calculateMedianTemperatureReal();

              // Rest of your code...
              // Initialize animations here
              _minimumTemperatureRealAnimation = Tween<double>(
                begin: 0,
                end: minTemperatureReal,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _averageAnimation = Tween<double>(
                begin: 0,
                end: averageTemperatureReal,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _maximumAnimation = Tween<double>(
                begin: 0,
                end: maxTemperatureReal,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );

              _medianAnimation = Tween<double>(
                begin: 0,
                end: medianTemperatureReal,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOut,
                ),
              );
            });
          }});
      });
    }
  }

  // Function to calculate the minimum temperature
  double calculateMinTemperatureReal() {
    double minTemperatureReal = temperatureReal.reduce(min);
    print('Min TemperatureReal: $minTemperatureReal');
    return minTemperatureReal;
  }

  // Function to calculate the maximum temperature
  double calculateMaxTemperatureReal() {
    double maxTemperatureReal = temperatureReal.reduce(max);
    print('Max TemperatureReal: $maxTemperatureReal');
    return maxTemperatureReal;
  }

  // Function to calculate the average temperature
  double calculateAverageTemperatureReal() {
    double sum = temperatureReal.reduce((a, b) => a + b);
    return sum / temperatureReal.length;
  }

  // Function to calculate the median temperature
  double calculateMedianTemperatureReal() {
    List<double> sortedTemperatureReal = [...temperatureReal];
    sortedTemperatureReal.sort();
    int middleIndex = sortedTemperatureReal.length ~/ 2;
    if (sortedTemperatureReal.length % 2 == 0) {
      return (sortedTemperatureReal[middleIndex - 1] +
          sortedTemperatureReal[middleIndex]) /
          2;
    } else {
      return sortedTemperatureReal[middleIndex];
    }
  }

@override
Widget build(BuildContext context) {
  if (_controller == null) {
    return CircularProgressIndicator();
  }
  return Scaffold(

    body: SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -100,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(0.1),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: -50,
              child: Icon(
                Icons.cloud,
                size: 100,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Current Readings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _controller.forward(from: 0);
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellowAccent.withOpacity(1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [   Colors.purple,
                              Colors.purpleAccent, ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Minimum',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Current: ${calculateMinTemperatureReal()}°C',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Location: Living Room',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 20,
                                    value: _maximumAnimation.value,
                                    backgroundColor: Colors.grey.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: _maximumAnimation.value * 6.3,
                                  child: Container(
                                    width: 3,
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${(calculateMinTemperatureReal() ).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _controller.forward(from: 0);
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellow.withOpacity(1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [   Colors.purple,
                              Colors.purple, ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Maximum',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Current: ${calculateMaxTemperatureReal()}°C',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Location: Living Room',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 20,
                                    value: _maximumAnimation.value,
                                    backgroundColor: Colors.yellow.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: _maximumAnimation.value * 6.3,
                                  child: Container(
                                    width: 3,
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${(_maximumAnimation.value ).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _controller.forward(from: 0);
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellow.withOpacity(1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:  [Colors.purple,Colors.purple, ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Average',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Current: ${calculateAverageTemperatureReal().toStringAsFixed(2)}°C',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Location: Living Room',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 20,
                                    value: _averageAnimation.value,
                                    backgroundColor: Colors.grey.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: _averageAnimation.value * 6.3,
                                  child: Container(
                                    width: 3,
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${(_averageAnimation.value ).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _controller.forward(from: 0);
                  },
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.yellow.withOpacity(1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:  [Colors.purple,Colors.purple, ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Median',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Current: ${ calculateMedianTemperatureReal().toStringAsFixed(2)}°C',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Location: humifity Living Room',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 20,
                                    value: _medianAnimation.value,
                                    backgroundColor: Colors.grey.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: _medianAnimation.value * 6.3,
                                  child: Container(
                                    width: 3,
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${(_medianAnimation.value ).toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),


              ],
            ),
          ],
        ),
      ),
    ),
  );
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
}

