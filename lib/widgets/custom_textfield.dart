import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final bool obscureText;

  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintext,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintext,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
