import 'package:flutter/material.dart';

class CustomRowInfo extends StatelessWidget {
  final String text1;
  final String text2;
  const CustomRowInfo({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(text1),
          Text(text2,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              )),
        ],
      ),
    );
  }
}
