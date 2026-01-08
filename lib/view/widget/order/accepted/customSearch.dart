import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/constant/color.dart';

class Customsearch extends StatelessWidget {
  final void Function()? onPressed;
  final TextEditingController? mycontroller;
  const Customsearch({super.key, this.onPressed, this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Appcolor.primary,
      autofocus: false,
      controller: mycontroller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Appcolor.primary)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        suffixIcon:
            IconButton(onPressed: onPressed, icon: const Icon(Icons.search)),
        hintText: 'SearchwithOrderNumber'.tr,
      ),
    );
  }
}
