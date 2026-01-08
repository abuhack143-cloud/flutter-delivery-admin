import 'package:flutter/material.dart';

class Customtextlink extends StatelessWidget {
  final String question;
  final String text;
  final void Function()? onTap;
  const Customtextlink(
      {super.key, required this.question, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
