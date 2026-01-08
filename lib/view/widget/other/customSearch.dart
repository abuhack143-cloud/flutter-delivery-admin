import 'package:admin/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customsearch extends StatelessWidget {
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;
  const Customsearch(
      {super.key, this.onPressed, this.mycontroller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
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
        hintText: 'search'.tr,
      ),
    );
  }
}
