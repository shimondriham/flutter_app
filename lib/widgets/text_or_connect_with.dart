import 'package:flutter/material.dart';

class TextOrConnectWith extends StatelessWidget {
  const TextOrConnectWith({super.key, required this.text});
  final String text ;

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Expanded(
        child: Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          'Or $text with',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      Expanded(
        child: Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
      ),
    ],
  );
  }
}