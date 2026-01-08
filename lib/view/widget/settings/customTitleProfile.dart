import 'package:flutter/material.dart';

import 'package:admin/core/constant/color.dart';

class CustomTitleProfile extends StatelessWidget {
  final String title;
  final String body;

  const CustomTitleProfile(
      {super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(body,
          style: const TextStyle(fontSize: 14, color: Appcolor.primary)),
      leading: Text(
        title,
        style: const TextStyle(
            fontSize: 16, color: Appcolor.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
