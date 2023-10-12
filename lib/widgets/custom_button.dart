import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() function;
  final String buttonText;
  const CustomButton(
      {super.key, required this.function, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.maxFinite,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
