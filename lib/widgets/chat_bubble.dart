import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool leftOrRight;
  const ChatBubble(
      {super.key, required this.message, required this.leftOrRight});

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry right = const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8));
    BorderRadiusGeometry left = const BorderRadius.only(
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(8),
      topLeft: Radius.circular(8),
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: leftOrRight ? left : right,
        color: Colors.blue,
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
