import 'package:app_iot/auth/AddUserScreen.dart';
import 'package:app_iot/auth/AdminScreen.dart';
import 'package:app_iot/auth/ModifyUserScreen.dart';
import 'package:app_iot/auth/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import 'SensorsAdminPage.dart';

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ManageUserPage(),
    );
  }
}





class ManageUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network('https://lottie.host/007f801e-410c-45b9-9a78-fd87d3a3a992/IBKTPhfSyy.json'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              icon: Icon(Icons.arrow_forward, size: 24),
              label: Text('Manage Users', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersAdminPage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 50, // Adjust this value as needed
            left: 30, // Adjust this value as needed
            child: FloatingActionButton(
              child: Icon(Icons.account_circle),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Color(0xFF737373),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_circle, color: Colors.blue),
                              title: Text('Profile', style: TextStyle(color: Colors.blue)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfilePage()),
                                );
                              },
                            ),
                            Divider(height: 1, color: Colors.grey),
                            ListTile(
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text('Logout', style: TextStyle(color: Colors.red)),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen()));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 20, // Adjust this value as needed
            right: 20, // Adjust this value as needed
            child: FloatingActionButton(
              child: Icon(Icons.switch_left),
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageSensorsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}







class ManageSensorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network('https://lottie.host/de98b293-9f22-4d17-b80b-e58c40bbfffb/FYwrxiuwKI.json'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              icon: Icon(Icons.arrow_forward, size: 24),
              label: Text('Manage Sensors', style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SensorsAdminPage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 50, // Adjust this value as needed
            left: 30, // Adjust this value as needed
            child: FloatingActionButton(
              child: Icon(Icons.account_circle),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Color(0xFF737373),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_circle, color: Colors.blue),
                              title: Text('Profile', style: TextStyle(color: Colors.blue)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfilePage()),
                                );
                              },
                            ),
                            Divider(height: 1, color: Colors.grey),
                            ListTile(
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text('Logout', style: TextStyle(color: Colors.red)),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen()));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 20, // Adjust this value as needed
            right: 20, // Adjust this value as needed
            child: FloatingActionButton(
              child: Icon(Icons.switch_left),
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUserPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




class UsersAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.network('https://lottie.host/71b65211-22b8-4313-bb1b-1a8dbe2ab067/nayVYmYkD0.json'),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.person_add, size: 24),
                  label: Text('Add User', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddUserScreen()),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.person_remove, size: 24),
                  label: Text('Delete User', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminScreen()),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.person_outline, size: 24),
                  label: Text('Modify User', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifyUserScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Color(0xFF737373),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_circle, color: Colors.blue),
                              title: Text('Profile', style: TextStyle(color: Colors.blue)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfilePage()),
                                );
                              },
                            ),
                            Divider(height: 1, color: Colors.grey),
                            ListTile(
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text('Logout', style: TextStyle(color: Colors.red)),
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen()));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.account_circle),
            ),
          ),
        ],
      ),
    );
  }
}





