import 'package:flutter/material.dart';

class Customtextauth extends StatelessWidget {
  final String text;
  const Customtextauth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
