import 'package:flutter/material.dart';
import 'package:admin/core/constant/color.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? backgroundColor;
  final Size minimumSize;
  final double? fontSize;
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.backgroundColor,
    required this.minimumSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? Colors.white10,
        minimumSize: minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadowColor: Appcolor.grey,
        elevation: 5,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
