import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 250, // Adjust the width to make the image wider
        height: 150, // Adjust the height to make the image taller
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          "images/cloud.png",
          // height: 160, // You can remove these lines as the height and width are already defined in the Container
          // width: 140, // You can remove these lines as the height and width are already defined in the Container
          // fit: BoxFit.fill,
        ),
      ),
    );
  }
}
