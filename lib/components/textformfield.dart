import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext;
  final TextEditingController mycontroller;

  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(1),
            spreadRadius: 4,
            offset: Offset(1.0, 1.0),
            blurRadius: 30.0, // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: const Color.fromARGB(255, 184, 184, 184)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
