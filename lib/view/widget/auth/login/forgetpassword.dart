import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetpasswordLink extends StatelessWidget {
  final void Function()? onTap;
  const ForgetpasswordLink({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: onTap,
          child: Text(
            "forget".tr,
          ),
        ));
  }
}
