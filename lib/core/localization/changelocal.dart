import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import 'package:admin/core/functions/fcmconfig.dart';
import 'package:admin/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  void changeLang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }

  Future requestPerLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Get.defaultDialog(
        title: "warning".tr,
        middleText: "Please_Open_location".tr,
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.defaultDialog(
          title: "warning".tr,
          middleText: "Please_accept_location".tr,
        );
      }

      if (permission == LocationPermission.deniedForever) {
        return Get.defaultDialog(
          title: "warning".tr,
          middleText: "Cant_run_app_without_location".tr,
        );
      }
    }
  }


Future<void> requestPermissionNotfication() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}


  Future<void> req() async {
    await requestPerLocation();
    await requestPermissionNotfication();
    fcmconfig();
  }

  @override
  void onInit() {
    req();
    update();
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      Jiffy.setLocale("ar");
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      Jiffy.setLocale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      Jiffy.setLocale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
