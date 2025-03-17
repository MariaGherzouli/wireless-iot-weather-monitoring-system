import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InaccessibleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text('Profile'),
                            onTap: () {
                              // Handle profile tap
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.info),
                            title: Text('About Us'),
                            onTap: () {
                              // Handle about us tap
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Log Out'),
                            onTap: () {
                              // Handle log out tap
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                width: 50, // Adjust the size as needed
                height: 50, // Adjust the size as needed
                child: Lottie.network('https://lottie.host/7b61c89e-13df-432e-bd6f-98a38c38c442/hKKp22GBQv.json'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
