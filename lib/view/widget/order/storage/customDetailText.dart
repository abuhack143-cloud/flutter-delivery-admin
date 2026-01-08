import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomDetailText extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomDetailText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Appcolor.primary),
        ),
        Text(
          text2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
