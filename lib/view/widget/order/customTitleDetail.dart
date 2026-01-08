import 'package:flutter/material.dart';

class CustomTitleDetail extends StatelessWidget {
  final String title;
  const CustomTitleDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Divider(
          height: 4,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          thickness: 5,
        ),
      ),
      Text(
        title,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
      ),
      Expanded(
        child: Divider(
          height: 4,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          thickness: 5,
        ),
      ),
    ]);
  }
}
