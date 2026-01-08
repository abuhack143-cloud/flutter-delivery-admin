import 'package:admin/view/widget/other/notification/customRadio.dart';
import 'package:flutter/material.dart';

class CustomRowRadio extends StatelessWidget {
  final String? errortext;
  final String titletext;
  final String radio1text;
  final String radio2text;
  final dynamic groupValue;
  final void Function(Object?)? onChanged1;
  final void Function(Object?)? onChanged2;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final bool error;

  const CustomRowRadio({
    super.key,
    this.errortext,
    required this.titletext,
    required this.radio1text,
    required this.radio2text,
    this.groupValue,
    this.onChanged2,
    this.onChanged1,
    this.onTap1,
    this.onTap2,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (error)
          Text(
            "$errortext",
            style: const TextStyle(color: Colors.red),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(titletext),
            CustomRadio(
              onTap: onTap1,
              title: radio1text,
              value: 1,
              groupValue: groupValue,
              onChanged: onChanged1,
            ),
            CustomRadio(
              onTap: onTap2,
              title: radio2text,
              value: 2,
              groupValue: groupValue,
              onChanged: onChanged2,
            ),
          ],
        ),
      ],
    );
  }
}
