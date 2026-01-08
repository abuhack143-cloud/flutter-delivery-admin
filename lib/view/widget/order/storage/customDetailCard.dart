import 'package:admin/view/widget/order/storage/customDetailText.dart';
import 'package:flutter/material.dart';

class CustomDetailCard extends StatelessWidget {
  final String c1Text1;
  final String c1Text2;
  final String c2Text1;
  final String c2Text2;
  final String c3Text1;
  final String c3Text2;
  final double? width;

  const CustomDetailCard(
      {super.key,
      required this.c1Text1,
      required this.c1Text2,
      required this.c2Text1,
      required this.c2Text2,
      required this.c3Text1,
      required this.c3Text2, this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:  EdgeInsets.symmetric(horizontal:width?? 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomDetailText(
            text1: c1Text1,
            text2: c1Text2,
          ),
          CustomDetailText(
            text1: c2Text1,
            text2: c2Text2,
          ),
          CustomDetailText(
            text1: c3Text1,
            text2: c3Text2,
          ),
        ],
      ),
    );
  }
}
