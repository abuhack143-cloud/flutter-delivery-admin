import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final void Function()? onTap;
  final int? groupValue;
  final void Function(Object?)? onChanged;
  final String title;
  final int value;
  final Key? k;
  const CustomRadio(
      {super.key,
      this.onTap,
      this.groupValue,
      this.onChanged,
      required this.title,
      required this.value,
      this.k});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Radio<int>(
            key: k,
            groupValue: groupValue,
            value: value,
            onChanged: onChanged,
            activeColor: Appcolor.primary,
          ),
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
