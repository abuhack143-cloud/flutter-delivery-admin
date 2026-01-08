import 'package:flutter/material.dart';
import 'package:admin/core/constant/color.dart';

class CustomButtonSubmit extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Widget? loading;

  const CustomButtonSubmit({
    super.key,
    this.onTap,
    required this.text,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Appcolor.primary,
          minimumSize: const Size(280, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadowColor: Appcolor.grey,
          elevation: 5,
        ),
        child: loading ??
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}
