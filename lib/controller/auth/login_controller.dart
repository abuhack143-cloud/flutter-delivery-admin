import 'package:admin/core/class/StatusRequest.dart';
import 'package:admin/core/constant/route.dart';
import 'package:admin/core/functions/handlingData_controller.dart';
import 'package:admin/core/services/services.dart';
import 'package:admin/data/datasource/remote/auth/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LoginController extends GetxController {
  login();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  LoginData loginData = LoginData(Get.find());

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  login() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.postData(
        email.text,
        password.text,
      );

      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        const storage = FlutterSecureStorage();
        if (response['status'] == "success") {
          myServices.sharedPreferences
              .setString("id", response['data']['admin_id'].toString());
          myServices.sharedPreferences
              .setString("username", response['data']['admin_name']);
          myServices.sharedPreferences
              .setString("email", response['data']['admin_email']);
          myServices.sharedPreferences
              .setString("role", response['data']['admin_role']);
          myServices.sharedPreferences
              .setString("image", response['data']['admin_image']);
          myServices.sharedPreferences.setString("step", '1');
          await storage.write(
              key: 'role', value: response['data']['admin_role']);

          myServices.saveToken(response['access_token']);
          myServices.saveRefreshToken(response['refresh_token']);
          Get.offAllNamed(AppRoute.homeSAdmin);
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: Text(
              "emailOrPassword".tr,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));

          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((value) {
      // String? token = value;
    });
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  void showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }
}
