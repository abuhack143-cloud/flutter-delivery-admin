import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/auth/login_controller.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customTextFormauth.dart';

class PasswordLogin extends StatelessWidget {
  const PasswordLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginControllerImp>(
      builder: (controller) => Customtextformauth(
        onTapIcon: () {
          controller.showPassword();
        },
        obscureText: controller.isshowpassword,
        hintText: 'hint_password'.tr,
        labelText: 'password'.tr,
        iconData: controller.isshowpassword
            ? Icons.lock_outline
            : Icons.lock_open_outlined,
        mycontroller: controller.password,
        valid: (val) {
          return validInput(val!, 8, 32, "password");
        },
        type: TextInputType.text,
      ),
    );
  }
}
