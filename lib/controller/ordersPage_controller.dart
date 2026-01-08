import 'dart:async';
import 'package:admin/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/core/services/services.dart';

class OrdersPageController extends GetxController with WidgetsBindingObserver {
  MyServices myServices = Get.find();
  Map<String, String> notiCounts = {
    "pending": "0",
    "delivering": "0",
    "deliveryFail": "0",
    "maincancel": "0",
    "city": "0",
    "custommer": "0",
    "delivered": "0",
  };

  Future<void> loadAllNotificationCounts() async {
    final prefs = myServices.sharedPreferences;
    await prefs.reload();
    notiCounts.updateAll((key, value) => prefs.getString(key) ?? "0");

    update();
  }

  void updateNoti(String pageKey, String newValue) async {
    final prefs = myServices.sharedPreferences;
    await prefs.reload();

    int current = int.tryParse(prefs.getString(pageKey) ?? "0") ?? 0;
    int toAdd = int.tryParse(newValue) ?? 0;
    int result = current + toAdd;

    notiCounts[pageKey] = result.toString();
    prefs.setString(pageKey, result.toString());

    update();
  }

  void resetNoti(String pageKey) async {
    final prefs = myServices.sharedPreferences;
    await prefs.reload();

    int noti = int.tryParse(prefs.getString("noti") ?? "0") ?? 0;
    int orderNoti = int.tryParse(prefs.getString(pageKey) ?? "0") ?? 0;

    int result = noti - orderNoti;
    if (result < 0) result = 0;

    // ✅ احفظ القيمة الجديدة قبل أن تحدث الواجهة
    await prefs.setString("noti", result.toString());

    await prefs.setString(pageKey, "0");

    // ✅ ثم حدث صفحة الهوم بعد الحفظ
    if (Get.isRegistered<HomeControllerImp>()) {
      Get.find<HomeControllerImp>().deleteNoti(result.toString());
    }

    notiCounts[pageKey] = "0";

    update();
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadAllNotificationCounts();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // ⬅️ نظف الذاكرة
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadAllNotificationCounts();
    }
  }
}
