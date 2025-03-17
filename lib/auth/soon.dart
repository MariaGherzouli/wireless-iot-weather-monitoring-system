import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Soon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Center(
          child: Lottie.network('https://lottie.host/8666ba9d-a124-4794-90fd-9ac9dd0984f2/xdzCivQokW.json'),
        ),
      ),
    );
  }
}
