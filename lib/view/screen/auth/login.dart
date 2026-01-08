import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/view/widget/auth/backgroundImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/controller/auth/login_controller.dart';
import 'package:admin/core/class/handlingdataview.dart';
import 'package:admin/core/functions/alertexitapp.dart';
import 'package:admin/core/functions/validinput.dart';
import 'package:admin/view/widget/auth/customButtonSubmit.dart';
import 'package:admin/view/widget/auth/login/password.dart';
import '../../widget/auth/customTEXTauth.dart';
import '../../widget/auth/customTextFormauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          // ignore: deprecated_member_use
          body: WillPopScope(
              onWillPop: alertExitApp,
              child: GetBuilder<LoginControllerImp>(
                builder: (controller) => Stack(
                  children: [
                    const Backgroundimage(),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      shape: const Border(
                        bottom: BorderSide(color: Colors.transparent),
                      ),
                      title: Text(
                        'title1'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 36),
                      ),
                    ),
                    HandlingDataRequest(
                      onPressed: () {
                        controller.statusRequest = StatusRequest.none;
                        controller.update();
                      },
                      statusRequest: controller.statusRequest,
                      widget: DraggableScrollableSheet(
                        snap: true,
                        initialChildSize: 0.57,
                        minChildSize: 0.57,
                        maxChildSize: 0.8,
                        builder: (context, scrollController) => Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30)),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Form(
                              key: controller.formstate,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Customtextauth(
                                          text: 'title2'.tr,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Customtextformauth(
                                          hintText: 'hint_email'.tr,
                                          labelText: 'email'.tr,
                                          iconData: Icons.email_outlined,
                                          mycontroller: controller.email,
                                          valid: (val) {
                                            return validInput(
                                                val!, 6, 254, "email");
                                          },
                                          type: TextInputType.text,
                                        ),
                                        const PasswordLogin(),
                                        CustomButtonSubmit(
                                          text: "title2".tr,
                                          onTap: () {
                                            controller.login();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
