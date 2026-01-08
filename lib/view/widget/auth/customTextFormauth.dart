import 'package:flutter/material.dart';
import 'package:admin/core/constant/color.dart';

class Customtextformauth extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final TextInputType? type;
  final bool? obscureText;
  final void Function()? onTapIcon;
  const Customtextformauth({
    super.key,
    this.obscureText,
    required this.hintText,
    required this.labelText,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.type,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: type,
        validator: valid,
        controller: mycontroller,
        cursorColor: Appcolor.primary,
        cursorOpacityAnimates: true,
        cursorErrorColor: Colors.red,
        obscureText: obscureText == null || obscureText == false ? false : true,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.red),
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white70
                : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(30)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Appcolor.primary),
              borderRadius: BorderRadius.circular(30)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(fontSize: 10),
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          label: Text(labelText),
          suffixIcon: InkWell(
            onTap: onTapIcon,
            child: Icon(iconData),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
